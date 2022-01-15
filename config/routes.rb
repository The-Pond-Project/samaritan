Rails.application.routes.draw do
  # resources :organizations
  root 'pages#home'

  # Service Workers
  get '/service-worker.js', to: 'service_workers/workers#index'
  get '/manifest.json', to: 'service_workers/manifests#index'

  # Users
  devise_for :users, skip: [:registrations, :invitation]
  devise_scope :user do
    resource :users,
            only: [:edit, :update, :destroy],
            controller: 'devise/registrations',
            as: :user_registration do
      get 'cancel'
    end
  end

  # Super Admin User
  authenticated :user, ->(u) { u.super_admin? } do
    devise_scope :user do
      get "/users/invitation/accept", to: "devise/invitations#edit",   as: 'accept_user_invitation'
      get '/users/invitation/new', to: 'devise/invitations#new', as: 'new_user_invitation'
      patch '/users/invitation', to: 'devise/invitations#update', as: 'user_invitation'
      put "/users/invitation", to: "devise/invitations#update", as:  nil
    end

    # scope '/manage' do 
      # resources :stories
  
      # resources :ponds, param: :key
    # end

    delete '/tags/:name', to: 'tags#destroy'

    delete '/ripples/:uuid', to: 'ripples#destroy'
  end 

  # Ponds
  get '/ponds', to: 'ponds#index'
  get '/ponds/:key', to: 'ponds#show', as: 'pond'

  # Ripples
  post '/ripples', to: 'ripples#create'
  get '/ripples', to: 'ripples#index'
  get '/ripples/:uuid', to: 'ripples#show', as: 'ripple'
  scope '/ponds/:key' do
    get '/ripples/new', to: 'ripples#new', as: 'new_pond_ripple'
  end

  # Tags
  post '/tags', to: 'tags#create'
  get '/tags', to: 'tags#index'
  get '/tags/new', to: 'tags#new', as: 'new_tag'
  get '/tags/:name', to: 'tags#show', as: 'tag'

  # Stories
  post '/stories', to: 'stories#create'
  get '/stories/new', to: 'stories#new', as: 'new_story'

  # Organizations
  resources :organizations, param: :name

  # Twilio Message Subscriptions
  post '/messagesubscriptions/sms', to: 'message_subscriptions#sms'

end
