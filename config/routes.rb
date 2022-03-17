Rails.application.routes.draw do

  unauthenticated do
    root 'pages#home'
  end 

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
    root 'ponds#index', as: :manager_root

    devise_scope :user do
      get "/users/invitation/accept", to: "devise/invitations#edit",   as: 'manage_accept_user_invitation'
      get '/users/invitation/new', to: 'devise/invitations#new', as: 'manage_new_user_invitation'
      patch '/users/invitation', to: 'devise/invitations#update', as: 'manage_user_invitation'
      put "/users/invitation", to: "devise/invitations#update", as:  nil
    end

    # Manage
    namespace :manage do
      get '/ripples', to: 'manage#ripples', as: 'ripples'
      get '/tags', to: 'manage#tags', as: 'tags'

      resources :ponds, param: :key do
        resources :ripples, param: :uuid
      end

      resources :tags, param: :name
      resources :stories, param: :uuid
      resources :bills
      resources :organizations, param: :name do 
        resources :releases
        resources :tags, param: :name, only: [:index, :show]
      end
    end
  end

  # Admin User
  authenticated :user, ->(u) { u.admin? } do
    # Manage
    namespace :manage do
      resources :ponds, param: :key do
        resources :ripples, param: :uuid
      end

      resources :tags, param: :name
      resources :stories, param: :uuid
      resources :organizations, param: :name do 
        resources :releases
        resources :tags, param: :name, only: [:index, :show]
      end
    end
  end 

  # Pages
  get '/ripples', to: 'pages#ripples'
  get '/impact', to: 'pages#impact'
  get '/donate', to: 'pages#donate'
  get '/contribute', to: 'pages#contribute'

  # Ponds and Ripples
  resources :ponds, param: :key, only: [:index, :show] do
    resources :ripples, param: :uuid, only: [:index, :show, :create, :new]
  end

  # Tags
  resources :tags, param: :name, only: [:index, :show, :new, :create]

  # Stories
  resources :stories, param: :uuid, only: [:new, :create]

  # Organizations
  resources :organizations, param: :name, only: [:index, :show] do 
    resources :releases, only: [:index, :show]
    resources :tags, param: :name, only: [:index, :show]
  end

  # Twilio Message Subscriptions
  post '/messagesubscriptions/sms', to: 'message_subscriptions#sms'

end
