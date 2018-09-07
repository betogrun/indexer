module Api
  module V1
    class WebsitesController < JSONAPI::ResourceController
      skip_before_action :verify_authenticity_token

      def post
        website = Website.find_or_initialize_by(url: params[:data][:attributes][:url])
        Services::Indexer.new(website).call unless website.invalid?
        # if website.present?
        @request.operations = [] # Remove create operation
        params[:id] = website.id
        @request.setup_show_action params
        # end
        super
      end
    end
  end
end
