FactoryBot.define do
  factory :website do
    url { FFaker::Internet.http_url }
    indexed { false }
  end
end
