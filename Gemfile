source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby `cat .ruby-version`.strip

group :development, :test do
  gem 'dotenv-rails'
end

gem 'config' # this gem should be load first to define configuration before initialize project
gem 'facets', require: false # It contains a lot of language improvements. Check this lib if you want to write something.

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.0.alpha2"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma'

gem 'billet', github: 'cimon-io/billet_core'

gem 'attribute_normalizer', github: 'cimon-io/attribute_normalizer' # Add more normalizers
gem 'page_meta_for', github: 'cimon-io/page_meta_for'
gem 'cancancan'
gem 'datetime_format_converter', github: 'cimon-io/datetime_format_converter'
gem 'glipper', github: 'cimon-io/glipper'
gem 'hamlit'
gem 'has_secure_token'
gem 'jbuilder'
gem 'oj'
gem 'oj_mimic_json'
gem 'simple_form'
gem 'susanin', github: 'cimon-io/susanin'
gem 'unobtrusive_resources', github: 'cimon-io/unobtrusive_resources'

# sidekiq
gem "redis"
gem 'redis-namespace'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'sidekiq-unique-jobs'
gem 'sinatra', require: false, github: 'sinatra/sinatra' # required for the sidekiq


# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

gem "importmap-rails", ">= 0.3.4"

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem 'active_record_query_trace'
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
  gem 'capybara'
  gem 'chromedriver-helper'
  gem 'factory_bot'
  gem 'rspec-rails', '~> 5.0'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'selenium-webdriver'
  gem 'unique'

  # Start debugger with binding.b [https://github.com/ruby/debug]
  gem "debug", ">= 1.0.0", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console", ">= 4.1.0"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler", ">= 2.3.3"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'database_cleaner'
  gem 'faker'
  gem 'rspec-simplecov'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'simplecov-console', github: 'cimon-io/simplecov-console' # Remove table and add separate coverage for non 100% files
  gem 'timecop'
end

group :production do
  gem 'rails_12factor'
  # gem 'raven'
end
