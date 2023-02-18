FactoryBot.define do
  factory :category do
    name { Faker::Lorem.words(number: 2).join(' ') }
    icon { Faker::Internet.url }
    user
  end
end
