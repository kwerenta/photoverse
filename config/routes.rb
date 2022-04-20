Rails.application.routes.draw do
  resources :posts
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root "posts#index"
end
