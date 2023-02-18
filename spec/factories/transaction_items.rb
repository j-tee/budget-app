FactoryBot.define do
  factory :transaction_item do
    name { Faker::Lorem.word }
    amount { Faker::Number.decimal(l_digits: 2) }
    user
  end
end
