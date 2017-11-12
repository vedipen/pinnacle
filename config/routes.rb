Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    member do
      get "like", to: "posts#upvote"
      get "dislike", to: "posts#downvote"
    end
    resources :comments
  end
  resource :profile
  get 'profile/index' => 'profiles#index'
  get 'profile/:id' => 'profiles#show', :as => :profile_id
  root 'posts#index'
end
