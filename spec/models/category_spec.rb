require 'rails_helper'
RSpec.describe Category, type: :model do
  it 'is valid with a name, icon, and user' do
    category = FactoryBot.build(:category)
    expect(category).to be_valid
  end
end
