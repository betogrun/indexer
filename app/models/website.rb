class Website < ApplicationRecord
  has_many :tags
  validates :url, presence: true
end
