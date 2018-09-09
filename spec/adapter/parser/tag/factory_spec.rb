require 'rails_helper'

RSpec.describe Parser::Tag::Factory do
  describe '#fabricate' do
    context 'tag is a header' do
      it do
        tag = double(:tag, name: ['h1', 'h2', 'h3'].sample)
        subject = described_class.new(tag)
        expect(Parser::Tag::Header).to receive(:new).with(tag)
        subject.fabricate
      end
    end

    context 'tag is a link' do
      it do
        tag = double(:tag, name: 'a')
        subject = described_class.new(tag)
        expect(Parser::Tag::Link).to receive(:new).with(tag)
        subject.fabricate
      end
    end
  end
end
