require 'indexer'

module Api
  module V1
    class WebsitesController < JSONAPI::ResourceController
      skip_before_action :verify_authenticity_token

      def create
        # binding.pry
        website = Website.find_or_initialize_by(url: params.dig(:data, :attributes, :url))
        return super if website.invalid?

        indexed_website = Services::Indexer.new(website).call
        render json: serialize(indexed_website)
      end

      def serialize(website)
        JSONAPI::ResourceSerializer
          .new(WebsiteResource)
          .serialize_to_hash(WebsiteResource.new(website, nil))
      end
    end
  end
end
