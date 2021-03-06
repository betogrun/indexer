module Api
  module V1
    class WebsiteResource < JSONAPI::Resource
      model_name 'Website'
      attributes :url, :indexed, :digest
      has_many :tags
    end
  end
end
