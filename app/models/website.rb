class Website < ApplicationRecord
  has_many :tags
  validates :url, presence: true
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp }, if: -> { url.present? }
end
