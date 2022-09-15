require 'sidekiq/web'
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
    # Sidekiq
    mount Sidekiq::Web => '/sidekiq'
    mount Flipper::UI.app(Flipper) => '/flipper'
    root 'manage/manage#dashboard', as: :manager_root

    devise_scope :user do
      get "/users/invitation/accept", to: "devise/invitations#edit",   as: 'manage_accept_user_invitation'
      get '/users/invitation/new', to: 'devise/invitations#new', as: 'manage_new_user_invitation'
      patch '/users/invitation', to: 'devise/invitations#update', as: 'manage_user_invitation'
      put "/users/invitation", to: "devise/invitations#update", as:  nil
    end

    # Manage
    namespace :manage do
      root 'manage#dashboard', as: :manager_root
      get '/ripples', to: 'manage#ripples', as: 'ripples'
      get '/releases', to: 'manage#releases', as: 'releases'
      get '/tags', to: 'manage#tags', as: 'tags'

      resources :ponds, param: :key do
        resources :ripples, param: :uuid
      end

      resources :tags, param: :name
      resources :stories, param: :uuid
      resources :orders, param: :uuid
      post '/orders/:uuid/send_message', to: 'orders#send_message', as: 'order_send_message'
      resources :bills
      resources :organizations, param: :name do 
        resources :releases do 
          resources :pond_batch_record, only: [:new, :create]
        end
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

      resources :orders, param: :uuid
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
  get '/privacy', to: 'pages#privacy_policy'
  get '/terms', to: 'pages#terms'
  get '/thank-you', to: 'pages#thank_you'
  get '/explained', to: 'pages#explained'
  get '/gracehaven', to: 'pages#partner', as: 'partner'

  # Orders
  resources :orders, param: :uuid, only: %i[show new create]

  # Donations
  resources :donations, only: [:create]

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

  # API Routes
  namespace :api do
    get '/_ping', to: 'health#ping'

    namespace :internal do
      resources :ponds, only: [:index, :show]
      resources :ripples, only: [:index, :show]
      resources :organizations, only: [:index, :show]
      resources :releases, only: [:index, :show]
      resources :tags, only: [:index, :show]
      resources :stories, only: [:index, :show]
      get '/impact', to: 'impact#show'
    end
  end
  

end
