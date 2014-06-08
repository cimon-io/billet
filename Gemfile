source 'https://rubygems.org'
ruby `cat .ruby-version`.strip

gem 'rails', '4.1.1'
gem 'pg'
gem 'clearance', github: 'thoughtbot/clearance', branch: '2.0'
gem 'haml-rails'
gem 'jbuilder', '~> 2.0'
gem 'rails_config'
gem 'cancancan'
gem 'paper_trail'
gem 'inherited_resources'
gem 'simple_form'
gem 'attribute_normalizer', github: 'mdeering/attribute_normalizer'
gem 'rails-observers'

gem 'premailer-rails'
gem 'nokogiri'

gem 'newrelic_rpm'

gem 'sidekiq'
gem 'sinatra', require: false # required for the sidekiq

# group :assets do
# rails 4 doesn't support assets group
gem 'sass-rails', '~> 4.0.3'
gem 'coffee-rails', '~> 4.0.1'
gem 'jquery-rails'
gem 'turbolinks'
gem 'uglifier'
gem 'bootstrap-sass'
gem 'liqueur', github: 'aratak/liqueur'
gem 'underscore-rails'
gem 'ejs'
# end

group :doc do
  gem 'sdoc', require: false
end

group :development do
  gem 'spring'
  gem 'thin'
  gem 'parallel_tests'

  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false

  gem 'quiet_assets'

  gem 'mailcatcher'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry', require: false
  gem 'pry-nav', require: false
  gem 'pry-doc', require: false

  gem 'rspec-rails', '~> 3.0.0.beta2'
  gem 'rspec-its', '~> 1.0.1'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'selenium-webdriver'
  gem 'site_prism', github: 'natritmeyer/site_prism', branch: 'master'
  gem 'email_spec'
  gem 'webmock'
end

group :production do
  gem 'unicorn'
  gem 'therubyracer', require: 'v8'
end
