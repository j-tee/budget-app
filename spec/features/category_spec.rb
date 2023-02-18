require 'rails_helper'

RSpec.feature 'CategoriesController', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before { sign_in(user) }

  describe 'index action' do
    let!(:categories) { FactoryBot.create_list(:category, 3, user:) }

    scenario 'displays a list of categories for the current user' do
      visit categories_path

      categories.each do |category|
        expect(page).to have_content(category.name)
      end
    end
  end

  describe 'new action' do
    scenario 'displays the new category form' do
      visit new_category_path

      expect(page).to have_field('Name')
      expect(page).to have_field('Icon')
      expect(page).to have_button('Add Category')
    end
  end

  describe 'create action' do
    let(:category_params) { FactoryBot.attributes_for(:category) }

    scenario 'creates a new category' do
      visit new_category_path

      fill_in 'Name', with: category_params[:name]
      fill_in 'Icon', with: category_params[:icon]
      click_button 'Add Category'

      expect(page).to have_content('Category created successfully!')
      expect(page).to have_content(category_params[:name])
    end
  end
end
