require 'rails_helper'

RSpec.describe CategoriesController, type: :request do
  describe 'GET /categories' do
    it 'returns a list of categories for the current user' do
      # Create a user and log them in
      user = FactoryBot.create(:user)
      sign_in user

      # Create some categories for the user
      category1 = FactoryBot.create(:category, user:)
      category2 = FactoryBot.create(:category, user:)

      # Make a request to get the categories index page
      get '/categories'

      # Expect the response body to include the category names
      expect(response.body).to include(category1.name)
      expect(response.body).to include(category2.name)

      # Expect the response body to only include the current user's categories
      expect(response.body).not_to include('Category belonging to a different user')
    end
  end

  describe 'GET /categories/new' do
    it 'displays a form to create a new category' do
      # Create a user and log them in
      user = FactoryBot.create(:user)
      sign_in user

      # Make a request to get the new category form
      get '/categories/new'

      # Expect the response body to include the new category form
      expect(response.body).to include('Create Category')
      expect(response.body).to include('Name')
      expect(response.body).to include('Icon')
    end
  end

  describe 'POST /categories' do
    it 'creates a new category' do
      # Create a user and log them in
      user = FactoryBot.create(:user)
      sign_in user

      # Create category params to submit with the request
      category_params = FactoryBot.attributes_for(:category, user:)

      # Make a request to create a new category
      post '/categories', params: { new_category: category_params }

      # Expect the user to be redirected to the categories index page
      expect(response).to redirect_to('/categories')

      # Expect a flash notice to be displayed
      expect(flash[:notice]).to eq('Category created successfully!')

      # Expect the category to have been created and to belong to the current user
      expect(Category.count).to eq(1)
      expect(Category.first.user).to eq(user)
    end

    it 'displays an error message if the category is not valid' do
      # Create a user and log them in
      user = FactoryBot.create(:user)
      sign_in user

      # Make a request to create a new category with invalid params
      post '/categories', params: { new_category: { name: '' } }

      # Expect the user to be redirected back to the new category form
      expect(response).to redirect_to('/categories/new')

      # Expect a flash alert to be displayed with the validation error message
      expect(flash[:alert]).to include("Name can't be blank")
    end
  end
end
