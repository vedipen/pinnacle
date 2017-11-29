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
  resources :profiles
  resource :profile
  resources :teamowners
  resource :teamowner
  resources :pmcmembers
  resource :pmcmember
  resources :teams
  resource :team

  root 'posts#index'


  get '/teamadd/:id', to: 'teams#addteam', as: 'add_participants_to_team'

end
