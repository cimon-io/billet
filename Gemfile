source 'https://rubygems.org'
ruby `cat .ruby-version`.strip

group :development, :test do
  gem 'dotenv-rails'
end

gem 'config', '~> 1.7'
gem 'rollbar', '~> 2.15'

gem 'pg', '~> 0.21'
gem 'puma', '~> 3.0'
gem 'rails', '>= 5.2.0', '< 5.3.0'

gem 'cancancan', '~> 2.1'
gem 'paper_trail', '~> 9.0'

gem 'attribute_normalizer', '~> 1.2'
gem 'carrierwave', '~> 1.2'
gem 'has_secure_token', '~> 1.0'
gem 'mini_magick', '~> 4.8'
gem 'money-rails', '~> 1.11'

gem 'datetime_format_converter', github: 'cimon-io/datetime_format_converter'
gem 'glipper', github: 'cimon-io/glipper'
gem 'hamlit', '~> 2.8'
gem 'jbuilder', '~> 2.5'
gem 'oj', '~> 3.5'
gem 'oj_mimic_json', '~> 1.0'
gem 'simple_form', '~> 4.0'
gem 'susanin', github: 'cimon-io/susanin'
gem 'unobtrusive_resources', github: 'cimon-io/unobtrusive_resources'

gem 'nokogiri', '~> 1.8'
gem 'premailer-rails', '~> 1.10'

gem 'redis-namespace', '~> 1.6'
gem 'sidekiq', '~> 5.1'
gem 'sidekiq-scheduler', '~> 2.2'
gem 'sidekiq-unique-jobs', '~> 5.0'
gem 'sinatra', require: false, github: 'sinatra/sinatra' # required for the sidekiq

gem 'omniauth'
gem 'omniauth-facebook', github: 'mkdynamic/omniauth-facebook'
gem 'omniauth-instagram', github: 'ropiku/omniauth-instagram'
gem 'omniauth-tumblr', github: 'jamiew/omniauth-tumblr'
gem 'omniauth-twitter', github: 'cimon-io/omniauth-twitter'

group :development, :test do
  gem 'pry', require: false
  gem 'pry-byebug'
  gem 'pry-doc', require: false
  gem 'pry-rails'

  gem 'rubocop', require: false

  gem 'database_cleaner', github: 'DatabaseCleaner/database_cleaner', branch: 'master'
  gem 'factory_bot_rails', '~> 4.8'
  gem 'rspec-its'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'web-console'
end

group :test do
  gem 'timecop'

  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'email_spec'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'poltergeist'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'site_prism'
end

group :production do
  gem 'newrelic_rpm'
  gem 'rails_12factor'
end
