require 'rails_helper'

RSpec.describe Parser::Nokogiri do
  before do
    @subject = described_class.new('http://some.url.com', ['tag_name'])
    @document = double(:document, content: 'content')
    parsed_url = double(:parsed_url)
    allow(URI).to receive(:parse).with('http://some.url.com').and_return(parsed_url)
    allow(parsed_url).to receive(:open)
    allow(Nokogiri::HTML::Document).to receive(:parse).and_return(@document)
  end

  describe '#digest' do
    it do
      expect(Digest::MD5).to receive(:hexdigest).with('content').and_return(:result)
      expect(@subject.digest).to eq(:result)
    end
  end

  describe '#tags' do
    before do
      @raw_tag = double(:raw_tag)
      @tag_instance = double(:tag_instance)
      @parsed_tag = double(:parsed_tag)
    end
    it do
      expect(@document).to receive(:css).with('tag_name').and_return([@raw_tag])
      expect(Parser::Tag::Factory).to receive(:new).with(@raw_tag).and_return(@tag_instance)
      expect(@tag_instance).to receive(:fabricate).and_return(@parsed_tag)
      expect(@subject.tags).to eq([@parsed_tag])
    end
  end

  describe '#changed?' do
    before { expect(@subject).to receive(:digest).and_return('digest') }

    context 'true' do
      it { expect(@subject.changed?('new_digest')).to eq(true) }
    end

    context 'false' do
      it { expect(@subject.changed?('digest')).to eq(false) }
    end
  end
end
