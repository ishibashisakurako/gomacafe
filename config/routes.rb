Rails.application.routes.draw do

  
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'users#index'
    resources :users, only: [:index, :show, :destroy]
  end

  devise_for :users
  root to: 'homes#top'

  resources :posts do
    resources :favorite, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update, :destroy]
get "search" => "searches#search"
end
