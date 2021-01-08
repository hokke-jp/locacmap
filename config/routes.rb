Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'pages#home'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  get '/easylogin', to: 'sessions#easy'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    get 'profile', on: :member
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i[new create edit update]
  resources :microposts, only: %i[index new create destroy]
end
