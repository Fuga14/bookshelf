FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    year { rand(1900..2024) }
    description { Faker::Lorem.paragraph }
    association :author, factory: :author
  end
  
  factory :book_without_author, class: 'Book' do
    title { Faker::Book.title }
    year { rand(1900..2024) }
    description { Faker::Lorem.paragraph }
    author_id { nil }
  end
end

