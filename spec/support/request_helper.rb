module RequestHelper
  def headers
    { 'Content-Type': 'application/vnd.api+json' }
  end

  def json_response
    JSON.parse(response.body).deep_symbolize_keys!
  end

  def json_response_attributes
    json_response[:data][:attributes]
  end
end
