Rails.application.routes.draw do
  post '/products', to: 'products#create'
  get '/products', to: 'products#index'
end
