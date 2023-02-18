require 'rails_helper'
RSpec.describe TransactionItem, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:category_transaction_items) }
    it { should have_many(:categories).through(:category_transaction_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
  end

  describe 'class methods' do
    describe '.total_user_amount' do
      let(:user) { FactoryBot.create(:user) }
      let!(:transaction_item1) { FactoryBot.create(:transaction_item, author: user, amount: 100) }
      let!(:transaction_item2) { FactoryBot.create(:transaction_item, author: user, amount: 200) }

      it 'returns the total amount of all transaction items for a user' do
        expect(TransactionItem.total_user_amount(user.id)).to eq(300)
      end
    end

    describe '.total_category_amount' do
      let(:user) { FactoryBot.create(:user) }
      let(:category) { FactoryBot.create(:category, user:) }
      let!(:transaction_item1) { FactoryBot.create(:transaction_item, author: user, amount: 100) }
      let!(:transaction_item2) { FactoryBot.create(:transaction_item, author: user, amount: 200) }
      let!(:category_transaction_item1) do
        FactoryBot.create(:category_transaction_item, category:, transaction_item: transaction_item1)
      end
      let!(:category_transaction_item2) do
        FactoryBot.create(:category_transaction_item, category:, transaction_item: transaction_item2)
      end

      it 'returns the total amount of all transaction items for a category and user' do
        expect(CategoryTransactionItem.total_category_amount(category.id)).to eq(300)
      end
    end
  end
end
