server '3.15.187.107', user: 'deploy', roles: %w{web app db}
set :rails_env, 'production'