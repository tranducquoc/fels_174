Rails.application.routes.draw do
  root                  "static_pages#home"
  post     "login"   =>   "sessions#create"
  get    "login"   => "sessions#new"
  delete  "logout"  =>   "sessions#destroy"
  get "signup"  => "users#new"

  resources :users
  resources :categories, only: [:index, :show] do
    resources :lessons, only: [:edit, :update]
  end
  resources :learn_lessons, only: [:new, :update]
  resources :words, only: [:index]
  resources :relationships, only: [:create, :destroy, :show]
  namespace :admin do
    resources :users, only: [:index, :show, :destroy]
    resources :categories, only: :index
  end
end
