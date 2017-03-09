Rails.application.routes.draw do
  # mount ForestLiana::Engine => '/forest'
  resources :challenges, :datapoints
  devise_for :users
  root to: "application#index"
  get 'info',			to: 'application#info'
  get 'dashboard',		to: 'application#dashboard'
  get 'rankings',		to: 'application#rankings'
end
