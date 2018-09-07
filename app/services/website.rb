module Services
  class CreateWebsite
    def initialize(url)
      @url = url
    end

    def call
      obtain_remote_digest
      create_or_update_website
    end

    def create_tags
      retrieved_tags.each do |retrieved_tag|
        website.tags << Tag.new(name: retrieved_tag.name, content: retrieved_tag.content)
      end
    end

    private

    def website
      website ||= Website.find_or_initialize_by(url: url)
    end

    def create_or_update_website
      
      return website if website.persisted? && website.digest == remote_digest
      website.tags = []
      website.tags = tags_for(url)
      website.save!
    end

    def remote_digest
      nokogiri_adapter.digest
    end

    def retrieved_tags
      nokogiri_adapter.tags
    end

    def nokogiri_adapter
      nokogiri_adapter ||= Adapter::Nokogiri.new(url)
    end
  end
end