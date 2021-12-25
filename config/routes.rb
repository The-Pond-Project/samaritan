Rails.application.routes.draw do
  root 'pages#home'

  # Service Workers
  get '/service-worker.js', to: 'service_workers/workers#index'
  get '/manifest.json', to: 'service_workers/manifests#index'

  devise_for :users

  # Pebbles
  get '/pebbles', to: 'pebbles#index'
  get '/pebbles/:pebble_key', to: 'pebbles#show', as: 'pebble'

  # Ripples
  delete '/ripples/:uuid', to: 'ripples#destroy'
  post '/ripples', to: 'ripples#create'
  get '/ripples', to: 'ripples#index'
  get '/ripples/:uuid', to: 'ripples#show', as: 'ripple'
  scope '/pebbles/:pebble_key' do
    get '/ripples/new', to: 'ripples#new', as: 'new_pebble_ripple'
  end

  # Tags
  delete '/tags/:name', to: 'tags#destroy'
  post '/tags', to: 'tags#create'
  get '/tags', to: 'tags#index'
  get '/tags/new', to: 'tags#new', as: 'new_tag'
  get '/tags/:name', to: 'tags#show', as: 'tag'

end
