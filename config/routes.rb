Rails.application.routes.draw do
  # service workers
  get '/service-worker.js', to: 'service_workers/workers#index'
  get '/manifest.json', to: 'service_workers/manifests#index'
  
  root 'pages#home'
end
