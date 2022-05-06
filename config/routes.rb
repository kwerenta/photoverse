Rails.application.routes.draw do
  resources :posts do |_post|
    resources :comments, only: %i[create update destroy]
  end

  resources :likes, only: %i[create destroy]

  get "/p/:username", to: "users#profile", as: "profile"
  post "/p/:username/follow", to: "users#follow_user", as: "new_follow"
  delete "/p/:username/follow", to: "users#unfollow_user", as: "destroy_follow"

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
