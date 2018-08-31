class Tag < ApplicationRecord
  belongs_to :website
  validates :name, :content, presence: true
end
