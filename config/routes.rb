Rails.application.routes.draw do

  devise_scope :user do
    post "guest_login", to: "users#guest_login"
  end

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
  end

  devise_for :users
  root to: 'homes#top'

  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    resource :relationships, only: [:create, :destroy]
    get "followings" => "relationships#followings", as:"followings"
    get "followers" => "relationships#followers", as: "followers"
    get 'favorite', to: 'users#favorite'
    get 'columns', to: 'users#columns'
  end

  get "search" => "searches#search"

  resources :genres, only: [:show]
  resources :others, only: [:show]

  resources :columns

  resources :expirations
end
