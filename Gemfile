source 'https://rubygems.org'
ruby `cat .ruby-version`.strip

group :development, :test do
  gem 'dotenv-rails'
end

gem 'config', '~> 2.0' # this gem should be load first to define configuration before initialize project

# core libraries
gem 'rails', '6.0.0'

# database library
gem 'pg', '~> 1.1'

# main server
gem 'puma', '~> 3.1'

gem 'attribute_normalizer', '~> 1.2'
gem 'cancancan', '~> 3.0'
gem 'carrierwave', '~> 1.2'
gem 'datetime_format_converter', github: 'cimon-io/datetime_format_converter'
gem 'glipper', github: 'cimon-io/glipper'
gem 'hamlit', '~> 2.8'
gem 'has_secure_token', '~> 1.0'
gem 'jbuilder', '~> 2.5'
gem 'mini_magick', '~> 4.8'
gem 'nokogiri', '~> 1.10'
gem 'oj', '~> 3.5'
gem 'oj_mimic_json', '~> 1.0'
gem 'omniauth'
gem 'omniauth-facebook', github: 'mkdynamic/omniauth-facebook'
gem 'omniauth-instagram', github: 'ropiku/omniauth-instagram'
gem 'omniauth-tumblr', github: 'jamiew/omniauth-tumblr'
gem 'omniauth-twitter', github: 'cimon-io/omniauth-twitter'
gem 'premailer-rails', '~> 1.10'
gem 'redcarpet', '~> 3.4'
gem 'redis-namespace', '~> 1.6'
gem 'sidekiq', '~> 5.1'
gem 'sidekiq-scheduler', '~> 3.0'
gem 'sidekiq-unique-jobs', '~> 6.0'
gem 'simple_form', '~> 5.0'
gem 'sinatra', require: false, github: 'sinatra/sinatra' # required for the sidekiq
gem 'susanin', github: 'cimon-io/susanin'
gem 'unobtrusive_resources', github: 'cimon-io/unobtrusive_resources'

group :development, :test do
  gem 'puma-fsevent_cleanup', '~> 0.1'

  gem 'pry', '~> 0.10', require: false
  gem 'pry-byebug', '~> 3.4'
  gem 'pry-doc', '~> 1.0', require: false
  gem 'pry-rails', '~> 0.3'

  gem 'active_record_query_trace', '~> 1.5'
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
  gem 'capybara'
  gem 'chromedriver-helper'
  gem 'db-query-matchers', '~> 0.9'
  gem 'factory_bot', '~> 5.0'
  gem 'fuubar', '~> 2.2', require: false
  gem 'rspec-rails', '~> 3.6'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'selenium-webdriver'
  # gem 'teaspoon-jasmine', '~> 2.3'
  gem 'unique'
end

group :development do
  gem 'listen', '~> 3.1'
  gem 'web-console', '~> 4.0'
end

group :test do
  gem 'database_cleaner', '~> 1.6'
  gem 'faker', '~> 2.1'
  gem 'rspec-its', '~> 1.2'
  gem 'rspec-simplecov', '~> 0.2'
  gem 'shoulda-matchers', '~> 4.1'
  gem 'simplecov', '~> 0.14'
  gem 'simplecov-console', github: 'cimon-io/simplecov-console' # Remove table and add separate coverage for non 100% files
  gem 'timecop', '~> 0.9'
end

group :production do
  gem 'rails_12factor'
  gem 'rollbar', '~> 2.15'
end
