require 'rails_helper'
require 'indexer'

RSpec.describe Services::Indexer do
  describe '#call' do
    before do
      @website = create(:website)
      @subject = described_class.new(@website)
      @target = double(:target)
      expect(Parser::Nokogiri).to(
        receive(:new).with(@website.url, ['h1', 'h2', 'h3', 'a']).and_return(@target)
      )
    end
    context 'target not changed' do
      it 'returns the existing website' do
        expect(@target).to receive(:changed?).with(@website.digest).and_return(false)
        expect(Services::Persistence).not_to receive(:new)
        expect(@subject.call).to eq(@website)
      end
    end

    context 'target changed' do
      before 'returns the new or updated website' do
        @persistance_instance = double(:persistance_instance)
        @target_instance = double(:target_instance)
        @peristed_website = double(:peristed_website)
      end

      it do
        expect(@target).to receive(:changed?).with(@website.digest).and_return(true)
        expect(Services::Persistence).to(
          receive(:new).with(@website, @target).and_return(@persistance_instance)
        )
        expect(@persistance_instance).to receive(:persist).and_return(@peristed_website)
        expect(@subject.call).to eq(@peristed_website)
      end
    end
  end
end
