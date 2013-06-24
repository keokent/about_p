AboutP::Application.routes.draw do
  match "/auth/github/callback", to: "sessions#callback", via: 'get'
  match "/signin", to: "sessions#new", via: 'get'
end
