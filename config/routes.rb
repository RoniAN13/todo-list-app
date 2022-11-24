Rails.application.routes.draw do
  resources :todo_lists do
    resources :todo_items ,only: [:create,:destroy,:update]
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "static_pages#home"
end
