Rails.application.routes.draw do
  root 'pages#home'
  get '/trend_all', to: 'pages#trend_all'
  get '/trend_month', to: 'pages#trend_month'
  get '/trend_week', to: 'pages#trend_week'
  get '/map', to: 'pages#map'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  patch '/users/:id/edit', to: 'users#update'
  get '/login', to: 'sessions#new'
  get '/easylogin', to: 'sessions#easy'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'password_resets/new'
  get 'password_resets/edit'
  get '/password_resets', to: 'password_resets#new'
  get 'search', to: 'searches#search'
  get 'sort', to: 'searches#sort'
  get 'sort_latest', to: 'searches#sort_latest'
  get 'sort_going', to: 'searches#sort_going'
  get 'sort_period_asc', to: 'searches#sort_period_asc'
  get 'sort_period_desc', to: 'searches#sort_period_desc'
  resources :users do
    member do
      patch 'update_avatar'
      get 'following'
      get 'followers'
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i[new create edit update]
  resources :microposts, only: %i[index show new create destroy]
  resources :relationships, only: %i[create destroy]
  resources :goings, only: %i[create destroy]
end
