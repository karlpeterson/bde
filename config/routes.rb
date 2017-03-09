Rails.application.routes.draw do
  # mount ForestLiana::Engine => '/forest'
  resources :challenges
  resources :datapoints
  devise_for :users
  root to: "application#index"
  get 'info',			to: 'application#info'
end
