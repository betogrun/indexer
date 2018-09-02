module Api
  module V1
    class TagResource < JSONAPI::Resource
      model_name 'Tag'
      attributes :name, :content
      has_one :website
    end
  end
end