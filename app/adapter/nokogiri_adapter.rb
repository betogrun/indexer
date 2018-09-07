require 'nokogiri'
require 'open-uri'

class NokogiriAdapter
  attr_reader :url, :tag_names

  def initialize(url, tag_names)
    @url = url
    @tag_names = tag_names
  end

  def target_digest
    Digest::MD5.new.digest(document.content)
  end

  def tags
    tag_names.flat_map { |tag| document.css(tag) }
  end

  private

  def document
    @document ||= Nokogiri::HTML(URI.parse(url).open)
  end
end
