Rails.application.routes.draw do
  post '/products', to: 'products#create'
  get '/products', to: 'products#index'
  patch '/products/deactivate/:id', to: 'products#deactivate'
end
