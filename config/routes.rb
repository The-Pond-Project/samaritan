Rails.application.routes.draw do

  root 'pages#home'
  # Pages
  get '/ripples', to: 'pages#ripples'

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

  devise_scope :user do
    get "/users/invitation/accept", to: "devise/invitations#edit",   as: 'accept_user_invitation'
    patch '/users/invitation', to: 'devise/invitations#update', as: 'user_invitation'
  end

  # Super Admin User
  authenticated :user, ->(u) { u.super_admin? } do
    devise_scope :user do
      get "/users/invitation/accept", to: "devise/invitations#edit",   as: 'manage_accept_user_invitation'
      get '/users/invitation/new', to: 'devise/invitations#new', as: 'manage_new_user_invitation'
      patch '/users/invitation', to: 'devise/invitations#update', as: 'manage_user_invitation'
      put "/users/invitation", to: "devise/invitations#update", as:  nil
    end

    
    namespace :manage do
      # Manage
      get '/ripples', to: 'manage#ripples', as: 'ripples'

      resources :ponds, param: :key do
        resources :ripples, param: :uuid
      end

      # post '/ponds/:key/ripples', to: 'ripples#create', as: 'pond_ripples'
      # patch '/ponds/:key/ripples', to: 'ripples#update'
      # put '/ponds/:key/ripples', to: 'ripples#update'
      # put '/ponds/:key/ripples/:uuid', to: 'ripples#update'

      resources :tags, param: :name
      resources :stories, param: :uuid
      resources :organizations, param: :name
    end
  end

  # Admin User
  authenticated :user, ->(u) { u.admin? } do
    namespace :manage do
      resources :ponds, param: :key do
        member do
          resources :ripples, param: :uuid
        end 
      end

      resources :tags, param: :name
      resources :stories, param: :uuid
      resources :organizations, param: :name
    end
  end 


  # Ponds and Ripples
  resources :ponds, param: :key, only: [:index, :show] do
    resources :ripples, param: :uuid, only: [:index, :show, :create, :new]
  end

  # Tags
  resources :tags, param: :name, only: [:index, :show, :new, :create]

  # Stories
  resources :stories, param: :uuid, only: [:new, :create]

  # Organizations
  resources :organizations, param: :name, only: [:index, :show]

  # Twilio Message Subscriptions
  post '/messagesubscriptions/sms', to: 'message_subscriptions#sms'

end
