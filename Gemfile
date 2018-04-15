source 'https://rubygems.org'
ruby `cat .ruby-version`.strip

group :development, :test do
  gem 'dotenv-rails'
end

gem 'config', '~> 1.7'
gem 'rollbar', '~> 2.15'

gem 'rails', '>= 5.2.0', '< 5.3.0'
gem 'pg', '~> 0.21'
gem 'puma', '~> 3.0'

gem 'paper_trail', '~> 9.0'
gem 'cancancan', '~> 2.1'

gem 'mini_magick', '~> 4.8'
gem 'carrierwave', '~> 1.2'
gem 'has_secure_token', '~> 1.0'
gem 'attribute_normalizer', '~> 1.2'
gem 'money-rails', '~> 1.11'

gem 'jbuilder', '~> 2.5'
gem 'oj', '~> 3.5'
gem 'oj_mimic_json', '~> 1.0'
gem 'hamlit', '~> 2.8'
gem 'glipper', github: 'cimon-io/glipper'
gem 'susanin', github: 'cimon-io/susanin'
gem 'simple_form', '~> 4.0'
gem 'datetime_format_converter', github: 'cimon-io/datetime_format_converter'

gem 'premailer-rails', '~> 1.10'
gem 'nokogiri', '~> 1.8'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '~> 4.1'
gem 'therubyracer', '>= 0.12.3', require: 'v8'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails', '~> 4.3'
gem 'turbolinks', '~> 5.1'
gem 'bootstrap-sass', '~> 3.3'

gem 'sidekiq', '~> 5.1'
gem 'sidekiq-scheduler', '~> 2.2'
gem 'sidekiq-unique-jobs', '~> 5.0'
gem 'redis-namespace', '~> 1.6'
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
  gem 'factory_bot_rails', '~> 4.8'
  gem 'database_cleaner', github: 'DatabaseCleaner/database_cleaner', branch: 'master'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
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
