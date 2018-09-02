require 'rails_helper'

RSpec.describe "Api::V1::Websites", type: :request do
  describe 'GET /api/v1/websites' do
    before do
      @stored_websites = [
        create(:website, :with_tags),
        create(:website, :with_tags)
      ]
      get '/api/v1/websites?include=tags', headers: headers
    end

    it { expect(response).to have_http_status(200) }

    it 'returns stored websites and its tags' do
      @stored_websites.each_with_index do |website, index|
        expect(json_response[:data][index]).to(
          include({ id: website.id.to_s, attributes: {url: website.url, indexed: website.indexed } })
        )
        website.tags.each do |tag|
          expect(
            json_response[:included].any? do |json|
              json >= {id: tag.id.to_s, attributes: {name: tag.name, content: tag.content}}
            end
          ).to eq(true)
        end
      end
    end
  end

  describe 'POST /api/v1/websites' do
    before do
      @params = {
      data: {
        type: 'websites',
        attributes: { url: 'http://albertorocha.me' }
        }
      }
      post '/api/v1/websites', params: @params.to_json, headers: headers
    end

    it { expect(response).to have_http_status(201) }

    it 'persists the given website' do
      website = Website.last
      expect(website.id).not_to be_nil
      expect(website.url).to eq('http://albertorocha.me')
      expect(website.indexed).to eq(false)
    end
  end
end
