lock "~> 3.17.0"

require 'capistrano-db-tasks'

set :application, "samaritan"
set :repo_url, "git@github.com:The-Pond-Project/samaritan.git"
set :deploy_to, '/home/deploy/samaritan'
set :branch, ENV['BRANCH'] if ENV['BRANCH']

set :linked_files, %w(config/database.yml config/master.key)
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)

set :keep_releases, 3
set :keep_assets, 3

set :db_local_clean, true
set :db_remote_clean, true

namespace :deploy do
  desc 'Restart Samaritan'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end