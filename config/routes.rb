Rails.application.routes.draw do
  resources :candidates
  devise_for :users
  root 'candidates#index'
  #root 'candidate_details#dashboard' #root controller candidate details
  #get 'Filter', to: "filter_page#filter_menu", as:"filter"
  get "Filter_Result",to: "candidates#filter_result", as: "filter_result"
  #get "Filter_sort", to: "candidates#sort", as: "sort"
  get "Sort", to: "candidates#sort", as: "sort"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
