Rails.application.routes.draw do
  resources :users, only: [:new, :create] do
    post :follow
    delete :unfollow
  end
  resources :sessions, only: [:create, :destroy]
  resources :home, only: [:index]
  resources :posts, only: [:create]

  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'signup', to: 'users#new', as: 'signup'

  # TODO There might be a better way.
  get '/following', to: 'users#following_users'
  get '/followers', to: 'users#followers'
  get '/who_to_follow/suggestions', to: 'users#who_to_follow', as: 'who_to_follow'

  resources :users, param: :screen_name, path: '/', only: [:show]
  root to: 'home#index'
end
