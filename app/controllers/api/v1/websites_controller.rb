module Api
  module V1
    class WebsitesController < JSONAPI::ResourceController
      skip_before_action :verify_authenticity_token
    end
  end
end
