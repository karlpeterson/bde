Rails.application.routes.draw do
  # mount ForestLiana::Engine => '/forest'
  devise_for :users
  root to: "application#index"
end
