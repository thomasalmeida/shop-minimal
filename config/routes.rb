Rails.application.routes.draw do
  post '/products', to: 'products#create'
  get '/products', to: 'products#index'
  patch '/products/:id/deactivate', to: 'products#deactivate'
end
