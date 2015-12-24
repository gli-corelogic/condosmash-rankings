Rails.application.routes.draw do
  root 'home#index'
  resources :players
  resources :matches
  get 'all_matches', :to => 'matches#show_all'
end
