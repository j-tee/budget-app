FactoryBot.define do
  factory :transaction_item do
    user { nil }
    name { 'MyString' }
    amount { '9.99' }
  end
end
