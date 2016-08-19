Rails.application.routes.draw do
  root                  "static_pages#home"
  post     "login"   =>   "sessions#create"
  get    "login"   => "sessions#new"
  delete  "logout"  =>   "sessions#destroy"
  get "signup"  => "users#new"
  resources :users
  resources :categories, only: [:index, :show]
  resources :words, only: [:index]
end
