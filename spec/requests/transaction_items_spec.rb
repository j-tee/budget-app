require 'rails_helper'

RSpec.describe TransactionItemsController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category, user:) }

  before do
    sign_in user
  end

  describe 'GET /transaction_items' do
    it 'returns a successful response' do
      get category_transaction_items_path(category_id: category.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /transaction_items/new' do
    it 'returns a successful response' do
      get new_category_transaction_item_path(category_id: category.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /transaction_items' do
    let(:valid_params) { { name: 'Rent', amount: 1000 } }
    let(:invalid_params) { { name: '' } }

    context 'with valid params' do
      it 'creates a new transaction item and category transaction item' do
        expect do
          post category_transaction_items_path(category_id: category.id), params: { new_transaction_item: valid_params }
        end.to change { TransactionItem.count }.by(1)
          .and change { CategoryTransactionItem.count }.by(1)

        expect(response).to redirect_to(categories_path)

        expect(flash[:notice]).to eq("Transaction created successfully! \\n Total amount for #{category.name} category updated")
      end
    end

    context 'with invalid params' do
      it 'displays an error message' do
        post category_transaction_items_path(category_id: category.id), params: { new_transaction_item: invalid_params }

        expect(response).to redirect_to(new_category_transaction_item_path(category_id: category.id))
        expect(flash[:alert]).to include("Name can't be blank")
      end
    end
  end
end
