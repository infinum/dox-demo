# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books
      resources :book_collections
      resources :authors
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
