source 'https://rubygems.org'
ruby `cat .ruby-version`.strip

group :development, :test do
  gem 'dotenv-rails'
end

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'

gem 'hamlit'
gem 'paper_trail'
gem 'simple_form'
gem 'cancancan'
gem 'rails_config'
gem 'mini_magick'
gem 'jbuilder', '~> 2.5'
gem 'oj'
gem 'oj_mimic_json'
gem 'carrierwave'
gem 'glipper', github: 'cimon-io/glipper'
gem 'susanin', github: 'cimon-io/susanin', branch: 'rails-5-support'
gem 'attribute_normalizer'

gem 'premailer-rails'
gem 'nokogiri'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'

gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'sidekiq-unique-jobs'
gem 'redis-namespace'
gem 'sinatra', require: false # required for the sidekiq

group :development, :test do
  gem 'pry-rails'
  gem 'pry', require: false
  gem 'pry-doc', require: false
  gem 'pry-byebug'

  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'spring-commands-rspec'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'timecop'

  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'poltergeist'
  gem 'phantomjs', :require => 'phantomjs/poltergeist'
  gem 'site_prism'
  gem 'email_spec'
  gem 'simplecov', require: false
end

group :production do
  gem 'rails_12factor'
  gem 'therubyracer', require: 'v8'
  gem 'newrelic_rpm'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
