Rails.application.routes.draw do
  get 'hiddenleaderboard/index'

  get 'leaderboard/index'

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
  resources :scoreboards
  resources :cryptics
  resources :hiddenleaderboards
  resources :companies
  resources :cstocks
  resources :ostocks
  resources :headlines
  root 'posts#index'

  get 'random/select' => 'random#select'
  get 'random' => 'random#index'
  get 'scoreboard' => 'scoreboards#index'
  get 'leaderboard' => 'leaderboard#index', as: 'originalscoreboard'
  get 'hiddenleaderboard' => 'hiddenleaderboard#index', as: 'finalleaderboard'
  get 'leaderboard/betting' => 'leaderboard#betting'
  get 'leaderboard/wallstreet' => 'leaderboard#wallstreet'
  get 'cryptic/solved' => redirect('/CrypticClues123.pdf'), as: 'cryptic_pdf'

end
