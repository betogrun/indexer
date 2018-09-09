require 'persistence'

module Services
  class Indexer
    attr_reader :website

    def initialize(website)
      @website = website
    end

    def call
      return website unless target.changed?(website.digest)
      Persistence.new(website, target).persist
    end

    private

    def target
      @target ||= Parser::Nokogiri.new(website.url, ::Tag::NAMES)
    end
  end
end
