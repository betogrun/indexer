require 'rails_helper'

RSpec.describe 'Api::V1::Websites', type: :request do
  describe 'GET /api/v1/websites' do
    before do
      @stored_websites = [
        create(:website, :with_tags),
        create(:website, :with_tags)
      ]
      get '/api/v1/websites?include=tags', headers: headers
    end

    it { expect(response).to have_http_status(200) }

    it 'returns the stored websites and its tags' do
      @stored_websites.each_with_index do |website, index|
        expect(json_response[:data][index]).to(
          include(
            id: website.id.to_s,
            attributes: { url: website.url, indexed: website.indexed, digest: website.digest }
          )
        )
        website.tags.each do |tag|
          expect(
            json_response[:included].any? do |json|
              json >= { id: tag.id.to_s, attributes: { name: tag.name, content: tag.content } }
            end
          ).to eq(true)
        end
      end
    end
  end

  describe 'POST /api/v1/websites' do
    context 'valid url' do
      before do
        @params = {
          data: {
            type: 'websites',
            attributes: { url: 'https://alberto-rocha.neocities.org/' }
          }
        }
      end

      around do |example|
        VCR.use_cassette 'test_website' do
          example.run
        end
      end

      context 'new website' do
        it 'creates and returns a new website' do
          post '/api/v1/websites', params: @params.to_json, headers: headers

          expect(response).to have_http_status(200)
          Website.last.tap do |website|
            expect(json_response[:data][:id]).to eq(website.id.to_s)
            expect(json_response_attributes[:url]).to eq(website.url)
            expect(json_response_attributes[:digest]).to eq(website.digest)
          end
        end
      end

      context 'existing website' do
        before { @persisted_website = create(:website, :test_website) }
        context 'target website has not changed' do
          it 'returns the persisted website' do
            post '/api/v1/websites', params: @params.to_json, headers: headers

            expect(response).to have_http_status(200)
            expect(json_response[:data][:id]).to eq(@persisted_website.id.to_s)
            expect(json_response_attributes[:url]).to eq(@persisted_website.url)
            expect(json_response_attributes[:digest]).to eq(@persisted_website.digest)
          end

          it 'does not create a new website' do
            expect do
              post '/api/v1/websites', params: @params.to_json, headers: headers
            end.to change { Website.count }.by(0)
          end

          it 'does not update the existing website' do
            post '/api/v1/websites', params: @params.to_json, headers: headers

            expect(Website.last).to eq(@persisted_website)
          end
        end

        context 'website has changed' do
          around do |example|
            VCR.use_cassette 'modified_test_website' do
              example.run
            end
          end

          before do
            @previous_website = @persisted_website.clone
            @previous_tags = @persisted_website.tags.map(&:clone)
          end

          it 'updates the persisted website' do
            post '/api/v1/websites', params: @params.to_json, headers: headers

            updated_website = @persisted_website.reload
            expect(@previous_website.id).to eq(updated_website.id)
            expect(@previous_website.digest).not_to eq(updated_website.digest)
            expect(@previous_tags).not_to eq(updated_website.tags)
          end

          it 'returns the persisted website' do
            post '/api/v1/websites', params: @params.to_json, headers: headers

            expect(response).to have_http_status(200)
            @persisted_website.reload
            expect(json_response[:data][:id]).to eq(@persisted_website.id.to_s)
            expect(json_response_attributes[:url]).to eq(@persisted_website.url)
            expect(json_response_attributes[:digest]).to eq(@persisted_website.digest)
          end
        end
      end
    end

    context 'invalid url' do
      it 'returns an error message' do
        @params = {
          data: {
            type: 'websites',
            attributes: { url: 'invalid_url' }
          }
        }
        post '/api/v1/websites', params: @params.to_json, headers: headers

        expect(response).to have_http_status(422)
        expect(json_response[:errors].first).to include(detail: 'url - is invalid')
      end
    end
  end
end
