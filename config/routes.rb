RailsStore::Application.routes.draw do
  resources :reviews
  resources :products
  
  # faking a delete by changing a product parameter
  put '/product/:id/add_to_cart' => 'products#add_to_cart', :as => :add_to_cart
  put '/product/:id/remove_from_cart' => 'products#remove_from_cart', :as => :remove_from_cart

  root :to => 'products#index'
end
