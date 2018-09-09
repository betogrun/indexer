RSpec.describe Parser::Tag::Link do
  describe '#content' do
    it do
      tag = double(:tag, :[] => 'url')
      subject = described_class.new(tag)
      expect(subject.content).to eq('url')
    end
  end
end
