# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.2'

gem 'active_model_serializers'
gem 'archive-zip',                    '~> 0.12.0'
gem 'bcrypt',                         '~> 3.1.7'
gem 'bootsnap',                       '>= 1.4.4', require: false
gem 'bootstrap'
gem 'chunky_png',                     '~> 1.4'
gem 'countries',                      '~> 4.1', '>= 4.1.2'
gem 'devise',                         '~> 4.8'
gem 'devise_invitable',               '~> 2.0.0'
gem 'flipper',                        '~> 0.24.1'
gem 'flipper-active_record',          '~> 0.24.1'
gem 'flipper-ui',                     '~> 0.24.1'
gem 'friendly_id',                    '~> 5.4.0'
gem 'geocoder',                       '~> 1.7'
gem 'haml-rails'
gem 'httparty',                       '~> 0.20.0'
gem 'honeybadger',                    '~> 4.0'
gem 'image_processing',               '~> 1.2'
gem 'local_time',                     '~> 2.1'
gem 'money'
gem 'pagy',                           '~> 5.10', '>= 5.10.1'
gem 'paper_trail',                    '~> 12.1'
gem 'paranoia'
gem 'pg',                             '~> 1.1'
gem 'psych',                          '~> 3.3.0'
gem 'puma',                           '~> 5.0'
gem 'rails',                          '~> 7.0', '>= 7.0.3'
gem 'rails_best_practices'
gem 'rdoc',                           '~> 6.3.3'
gem 'react-rails',                    '~> 2.6', '>= 2.6.2'
gem 'redis',                          '~> 4.0'
gem 'rqrcode',                        '~> 2.0'
gem 'rubyzip',                        '~> 2.3', '>= 2.3.2'
gem 'sass-rails',                     '>= 6'
gem 'sidekiq',                        '~> 5.2', '>= 5.2.8'
gem 'sidekiq-failures',               '~> 1.0', '>= 1.0.1'
gem 'stripe'
gem 'stripe_event'
gem 'time-lord',                      '~> 1.0'
gem 'turbolinks',                     '~> 5'
gem 'twilio-ruby'
gem 'webpacker',                      '~> 5.0'
gem 'wisper',                         '~> 2.0', '>= 2.0.1'
gem 'wisper-sidekiq',                 '~> 1.3'

group :development, :test do
  gem 'brakeman'
  gem 'bullet'
  gem 'bundler-audit'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'html2haml', '~> 2.2'
  gem 'rspec-junklet'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'ruby_audit'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'wisper-rspec',     '~> 1.1'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'simplecov'
  gem 'stripe-ruby-mock', '~> 3.0.1', require: 'stripe_mock'
end

group :development do
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'web-console', '>= 4.1.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
