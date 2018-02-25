Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/login', to: "login#index"
  post '/login', to: "login#create"
  get '/register', to: "register#index"
  post '/register', to: "register#create"
  get '/logout', to: "login#logout"
  get '/dash', to: "dash#index"
  get '/profile', to: "profile#index"
  patch '/profile', to: "profile#updateProfile"
  post '/snaps', to: "profile#uploadSnap"
  get '/search', to: "dash#searchPage"
  post '/follow', to: "dash#follow"
  post '/unfollow', to: "dash#unfollow"
  post '/uploadSnap', to: "dash#upload_snap"
  get '/follow.:id', to: "dash#followProfile"
  delete '/delete_snap/:id', to: "profile#deleteSnap"
  # post '/search', to: "dash#searchResult"
  root 'dash#index'
end
