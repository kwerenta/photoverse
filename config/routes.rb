Rails.application.routes.draw do
  resources :posts, except: %i[index new] do
    resources :comments, only: %i[create update destroy]
  end

  get "/explore", to: "posts#explore", as: "explore"

  resources :likes, only: %i[create destroy]

  scope "/p/:username" do
    get "/", to: "users#profile", as: :profile
    post "follow", to: "users#follow", as: :new_follow
    delete "follow", to: "users#unfollow", as: :destroy_follow
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
