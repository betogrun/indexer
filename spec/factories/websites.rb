FactoryBot.define do
  factory :website do
    url { FFaker::Internet.http_url }
    indexed { false }
    digest { SecureRandom.hex(32) }

    trait :with_tags do
      indexed { true }
      after(:create) do |website|
        %i[h1 h2 h3 a_href].each do |tag|
          create_list(:tag, 3, tag, website: website)
        end
      end
    end

    trait :test_website do
      indexed { true }
      digest { '716a2e37519501e40ffdb75f238e6c6d' }
      url { 'https://alberto-rocha.neocities.org/' }
      after(:create) do |website|
        [
          { h1: 'Welcome to my Website!' },
          { h2: 'This is a h2 header' },
          { h2: 'This is another h2 header' },
          { h3: 'This is a simple h3 header' },
          { h3: 'This is also a h3 header' },
          { a_href: 'https://blog.albertorocha.me/' },
          { a_href: 'https://www.linkedin.com/in/betogrun/' }
        ].each do |tag|
          tag.each do |name, content|
            create(:tag, name, content: content, website: website)
          end
        end
      end
    end
  end
end
