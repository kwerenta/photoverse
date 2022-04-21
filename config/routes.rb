Rails.application.routes.draw do
  get "/p/:id", to: "profiles#show", as: "profile"
  resources :posts do |_post|
    resources :comments, only: %i[create update destroy]
  end

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  devise_scope :user do
    # Redirects signing out and cancelling users back to sign-in
    get "users", to: "devise/sessions#new"
    delete "users", to: "devise/sessions#new"
  end

  root "posts#index"
end
