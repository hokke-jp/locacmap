Rails.application.routes.draw do
  root 'pages#home'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  get '/easylogin', to: 'sessions#easy'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    get 'profile', on: :member
  end
  resources :microposts, only: %i[index new create destroy]
end
