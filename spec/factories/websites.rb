FactoryBot.define do
  factory :website do
    url { FFaker::Internet.http_url }
    indexed { false }

    trait :with_tags do
      indexed { true }
      after(:create) do |website|
        %i[h1 h2 h3 a_href].each do |tag|
          create_list(:tag, 3, tag, website: website)
        end
      end
    end
  end
end
