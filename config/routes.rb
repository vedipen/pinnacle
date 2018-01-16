Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    member do
      get "like", to: "posts#upvote"
      get "dislike", to: "posts#downvote"
    end
    resources :comments
  end
  resources :profiles
  resource :profile
  resources :teamowners
  resource :teamowner
  resources :pmcmembers
  resource :pmcmember
  resources :teams
  resource :team
  resources :hiddens
  resource :hidden
  resources :viri
  resources :anti_viri
  resources :bets
  root 'posts#index'

  get 'random/select' => 'random#select'
  get 'random' => 'random#index'

end
