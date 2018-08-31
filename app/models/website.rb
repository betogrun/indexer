class Website < ApplicationRecord
  validates :url, presence: true
end
