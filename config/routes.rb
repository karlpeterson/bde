Rails.application.routes.draw do
  # mount ForestLiana::Engine => '/forest'
  resources :challenges, :datapoints
  devise_for :users, :controllers => { registrations: 'registrations' }
  authenticated :user do
  	root to: 'challenges#dashboard', as: :authenticated_root
  end
  root to: "application#index"
  get 'info',			to: 'application#info'
  get 'thanks',     to: 'application#thanks'
  get 'dashboard',		to: 'challenges#dashboard'
  get 'rankings',		to: 'challenges#rankings'
end
