require 'rails_helper'

RSpec.feature 'TransactionItemsController', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before { sign_in(user) }

  describe 'index action' do
    let(:category) { FactoryBot.create(:category) }
    let!(:transaction_items) { FactoryBot.create_list(:transaction_item, 3) }

    before do
      category.transaction_items << transaction_items
    end

    scenario 'displays a list of transactions for a category' do
      visit category_transaction_items_path(category)

      transaction_items.each do |transaction_item|
        expect(page).to have_content(transaction_item.name)
        expect(page).to have_content(transaction_item.amount)
      end
    end
  end

  describe 'new action' do
    let(:category) { FactoryBot.create(:category) }

    scenario 'displays the new transaction item form' do
      visit new_category_transaction_item_path(category_id: category.id)

      expect(page).to have_field('Name')
      expect(page).to have_field('Amount')
      expect(page).to have_button('Add Transaction')
    end
  end

  describe 'create action' do
    let(:category) { FactoryBot.create(:category, user:) }
    let(:transaction_item_params) { FactoryBot.attributes_for(:transaction_item) }

    scenario 'creates a new transaction item for the category' do
      visit new_category_transaction_item_path(category_id: category.id)

      fill_in 'Name', with: transaction_item_params[:name]
      fill_in 'Amount', with: transaction_item_params[:amount]
      click_button 'Add Transaction'
      expect(page).to have_content('Transaction created successfully!')
      expect(page).to have_content(category.user.name)
      expect(page).to have_content(transaction_item_params[:amount])
    end
  end
end
