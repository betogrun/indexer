require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'factory' do
    it do
      tag = create(:website)
      expect(tag).to be_valid
    end
  end
end
