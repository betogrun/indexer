FactoryBot.define do
  factory :tag do
    name { ['h1','h2','h3', 'a'].sample }
    content { "Tag content" }
    website

    trait :h1 do
      name { 'h1' }
    end

    trait :h2 do
      name { 'h2' }
    end

    trait :h3 do
      name { 'h3' }
    end

    trait :a do
      name { 'a' }
    end
  end
end
