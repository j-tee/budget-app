# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'home#index'
  resources :categories, only: [:index, :new, :create] do
  resources :transaction_items, only: [:index, :new, :create, :show]
  end
end
