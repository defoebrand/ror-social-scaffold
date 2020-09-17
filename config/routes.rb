Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :friendships
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  post '/friend_request', :to => 'users#friend_requests'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
