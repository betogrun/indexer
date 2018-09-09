module Services
  class Persistence
    attr_reader :website, :target

    def initialize(website, target)
      @website = website
      @target = target
    end

    def persist
      website.tap do |ws|
        ws.digest = target.digest
        ws.indexed = true
        ws.tags = tags
        ws.save
      end
    end

    private

    def tags
      target.tags.map { |tag| ::Tag.new(tag.extract) }
    end
  end
end
