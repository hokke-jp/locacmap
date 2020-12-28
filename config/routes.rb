Rails.application.routes.draw do
  root 'peges#home'
  get  '/signup',  to: 'users#new'
end
