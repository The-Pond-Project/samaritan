Rails.application.routes.draw do
  root 'pages#home'

  # service workers
  get '/service-worker.js', to: 'service_workers/workers#index'
  get '/manifest.json', to: 'service_workers/manifests#index'

  devise_for :users

  # pebbles
  get '/pebbles', to: 'pebbles#index'
  get '/pebbles/:pebble_key', to: 'pebbles#show', as: 'pebble'
  
end
