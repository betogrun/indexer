require 'rails_helper'

RSpec.describe Services::Persistence do
  describe '#persist' do
    before do
      tag = double(:tag, extract: { name: 'name', content: 'content' })
      target = double(
        :target,
        digest: 'digest',
        tags: [tag]
      )
      website = build(:website)
      @subject = described_class.new(website, target)
    end
    it do
      @subject.persist
      Website.last.tap do |website|
        expect(website.digest).to eq('digest')
        expect(website.indexed).to eq(true)
        website.tags.each do |tag|
          expect(tag.name).to eq('name')
          expect(tag.content).to eq('content')
        end
      end
    end
  end
end
