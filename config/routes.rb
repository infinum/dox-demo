Rails.application.routes.draw do
  resources :books
  resources :book_collections
  resources :authors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
