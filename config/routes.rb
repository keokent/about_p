AboutP::Application.routes.draw do
  resources :users, except: [:destroy] do
    get 'search', :on => :collection
  end

  root :to => "users#index"
  match "/auth/github/callback", to: "sessions#callback", via: 'get'
  match "/signin", to: "sessions#new", via: 'get'
  match "/signout", to: "sessions#destroy", via: 'delete'
end
