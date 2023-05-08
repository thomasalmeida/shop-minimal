Rails.application.routes.draw do
  post '/products', to: 'products#create'
end
