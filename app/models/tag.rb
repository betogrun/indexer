class Tag < ApplicationRecord
  belongs_to :website
  validates :name, :content, presence: true
  NAMES = %w[h1 h2 h3 a].freeze
end
