require 'nokogiri'
require 'open-uri'
require 'parser/tag/factory'

module Parser
  class Nokogiri
    attr_reader :url, :tag_names

    def initialize(url, tag_names)
      @url = url
      @tag_names = tag_names
    end

    def digest
      @digest ||= Digest::MD5.hexdigest(document.content)
    end

    def tags
      raw_tags.each_with_object([]) do |raw_tag, memo|
        memo << Tag::Factory.new(raw_tag).fabricate
      end
    end

    def changed?(current_digest)
      digest != current_digest
    end

    private

    def raw_tags
      tag_names.flat_map { |tag| document.css(tag) }
    end

    def document
      @document ||= ::Nokogiri::HTML(URI.parse(url).open)
    end
  end
end
