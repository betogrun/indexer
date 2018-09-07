module Services
  class Indexer
    def initialize(website)
      @website = website
    end

    def call
      return website if website.persisted? && website.digest == target_digest
      Persistence::Website.new(website, tags, target_digest).persist!
    end

    private

    def tags
      target_tags.map do |target_tag|
        Tag::Factory.new(target_tag).fabricate
      end
    end

    def target_digest
      adapter.digest
    end

    def target_tags
      adapter.tags
    end

    def adapter
      adapter ||= NokogiriAdapter.new(url, Tag::NAMES)
    end
  end
end