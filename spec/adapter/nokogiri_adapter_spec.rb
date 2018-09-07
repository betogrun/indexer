require 'rails_helper'

RSpec.describe NokogiriAdapter do
  before do
    @subject = NokogiriAdapter.new('http://some.url.com', ['tag_name'])
    @document = double(:document, content: 'content')
    allow(NokogiriAdapter).to receive(:open)
    allow(Nokogiri::HTML::Document).to receive(:parse).and_return(@document)
  end

  describe '#target_digest' do
    it do
      digest_instance = double(:digest_instance)
      expect(Digest::MD5).to receive(:new).and_return(digest_instance)
      expect(digest_instance).to receive(:digest).with('content').and_return(:result)
      expect(@subject.target_digest).to eq(:result)
    end
  end

  describe '#tags' do
    it do
      expect(@document).to receive(:css).with('tag_name').and_return(['tag'])
      expect(@subject.tags).to eq(['tag'])
    end
  end
end