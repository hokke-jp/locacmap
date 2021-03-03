Rails.application.routes.draw do
  root 'pages#home'
  get 'map', to: 'pages#map'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  patch 'users/:id/edit', to: 'users#update'
  get 'login', to: 'sessions#new'
  get 'easylogin', to: 'sessions#easy'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'password_resets/new'
  get 'password_resets/edit'
  patch 'password_resets/:id/edit', to: 'password_resets#update'
  get 'password_resets', to: 'password_resets#new'
  get 'search', to: 'searches#search'
  get 'sort', to: 'searches#sort'
  resources :users, only: %i[show new create edit update destroy] do
    member do
      patch 'update_avatar'
      get 'following'
      get 'followers'
      get 'related_info'
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i[new create edit update]
  resources :microposts, only: %i[index show new create destroy]
  resources :relationships, only: %i[create destroy]
  resources :goings, only: %i[create destroy]
end
