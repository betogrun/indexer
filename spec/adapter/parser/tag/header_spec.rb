RSpec.describe Parser::Tag::Header do
  describe '#content' do
    it do
      tag = double(:tag, text: 'text')
      subject = described_class.new(tag)
      expect(subject.content).to eq('text')
    end
  end
end
