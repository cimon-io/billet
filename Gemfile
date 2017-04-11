source 'https://rubygems.org'
ruby `cat .ruby-version`.strip

group :development, :test do
  gem 'dotenv-rails'
end
gem 'rails_config', github: 'cimon-io/rails_config' #rails 5.1 support
gem 'rollbar'

gem 'rails', '= 5.1.0.rc1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'

gem 'paper_trail'
gem 'cancancan'

gem 'mini_magick'
gem 'carrierwave'
gem 'has_secure_token'
gem 'attribute_normalizer'
gem 'money-rails'

gem 'jbuilder', '~> 2.5'
gem 'oj'
gem 'oj_mimic_json'
gem 'hamlit'
gem 'glipper', github: 'cimon-io/glipper'
gem 'susanin', github: 'cimon-io/susanin'
gem 'simple_form'
gem 'datetime_format_converter', github: 'cimon-io/datetime_format_converter'

gem 'premailer-rails'
gem 'nokogiri'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', '>= 0.12.3', require: 'v8'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'bootstrap-sass'

gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'sidekiq-unique-jobs'
gem 'redis-namespace'
gem 'sinatra', require: false, github: 'sinatra/sinatra' # required for the sidekiq

gem 'omniauth'
gem 'omniauth-facebook', github: 'mkdynamic/omniauth-facebook'
gem 'omniauth-twitter', github: 'cimon-io/omniauth-twitter'
gem 'omniauth-instagram', github: 'ropiku/omniauth-instagram'
gem 'omniauth-tumblr', github: 'jamiew/omniauth-tumblr'

group :development, :test do
  gem 'pry-rails'
  gem 'pry', require: false
  gem 'pry-doc', require: false
  gem 'pry-byebug'

  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'spring-commands-rspec'
  gem 'factory_girl_rails'
  gem 'database_cleaner', github: 'DatabaseCleaner/database_cleaner', branch: 'master'
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
  gem 'newrelic_rpm'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
