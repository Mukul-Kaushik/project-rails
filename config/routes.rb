# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :candidates
  devise_for :users
  root 'candidates#dashboard'
  match '/Filter_Result', to: 'candidates#filter_result', as: 'filter_result',
  via: [:post, :get]
  get 'counselling', to: 'candidates#counselling_page', as: 'counsellings'
  post 'save_counselling', to: 'candidates#save_counselling', as: 'save_counselling'
  get 'Sort', to: 'candidates#sort', as: 'sort'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
