FactoryBot.define do
  factory :tag do
    name { ['h1','h2','h3', 'a_href'].sample }
    content { FFaker::Lorem.sentence }
    website

    trait(:h1) { name { 'h1' } }
    trait(:h2) { name { 'h2' } }
    trait(:h3) { name { 'h3' } }

    trait(:a_href) do
      name { 'a' }
      content { FFaker::Internet.http_url }
    end
  end
end
