# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :candidates
  devise_for :users
  root 'candidates#dashboard'
  match '/Filter_Result', to: 'candidates#filter_result', as: 'filter_result',
  via: [:post, :get]
  get 'counseling', to: 'candidates#counseling_page', as: 'counseling'
  get 'Sort', to: 'candidates#sort', as: 'sort'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
