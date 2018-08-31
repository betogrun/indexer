require 'rails_helper'

RSpec.describe Website, type: :model do
  describe 'factory' do
    it do
      website = create(:website)
      expect(website).to be_valid
    end
  end
end
