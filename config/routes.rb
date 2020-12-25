Rails.application.routes.draw do
  get 'peges/home'
  root 'peges#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
