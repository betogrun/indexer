require 'rails_helper'

RSpec.describe Parser::Tag::Base do
  describe '#content' do
    it do
      subject = described_class.new(double(:tag))
      expect { subject.content }.to raise_error(NotImplementedError)
    end
  end
end
