Rails.application.routes.draw do
  root 'comics#index'

  resources :comics, only: [:index, :show] do
    collection do
      get 'search'
    end

    member do
      post 'upvote'
    end
  end
end
