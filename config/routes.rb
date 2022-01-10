Rails.application.routes.draw do
  # resources :organizations
  root 'pages#home'

  # Service Workers
  get '/service-worker.js', to: 'service_workers/workers#index'
  get '/manifest.json', to: 'service_workers/manifests#index'

  devise_for :users

  # Ponds
  get '/ponds', to: 'ponds#index'
  get '/ponds/:key', to: 'ponds#show', as: 'pond'

  # Ripples
  delete '/ripples/:uuid', to: 'ripples#destroy'
  post '/ripples', to: 'ripples#create'
  get '/ripples', to: 'ripples#index'
  get '/ripples/:uuid', to: 'ripples#show', as: 'ripple'
  scope '/ponds/:key' do
    get '/ripples/new', to: 'ripples#new', as: 'new_pond_ripple'
  end

  # Tags
  delete '/tags/:name', to: 'tags#destroy'
  post '/tags', to: 'tags#create'
  get '/tags', to: 'tags#index'
  get '/tags/new', to: 'tags#new', as: 'new_tag'
  get '/tags/:name', to: 'tags#show', as: 'tag'

  # Stories
  post '/stories', to: 'stories#create'
  get '/stories/new', to: 'stories#new', as: 'new_story'#Org

  # Organizations
  delete '/organizations/:name', to: 'organizations#destroy'
  post '/organizations', to: 'organizations#create'
  get '/organizations', to: 'organizations#index'
  get '/organizations/new', to: 'organizations#new', as: 'new_organization'
  get '/organizations/:name', to: 'organizations#show', as: 'organization'
  patch '/organizations/:name', to: 'organizations#update'
  put '/organizations/:name', to: 'organizations#update'
  get '/organizations/:name/edit', to: 'organizations#edit', as: 'edit_organization'

  # Twilio Message Subscriptions
  post '/messagesubscriptions/sms', to: 'message_subscriptions#sms'

end
