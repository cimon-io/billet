source 'https://rubygems.org'
ruby `cat .ruby-version`.strip

gem 'rails', '4.2.1'
gem 'pg'
gem 'clearance', '~> 1.8.1'
gem 'haml'
gem 'jbuilder', '~> 2.0'
gem 'rails_config'
gem 'cancancan'
gem 'paper_trail'
gem 'inherited_resources'
gem 'simple_form', '~> 3.1.0.rc2'
gem 'postrank-uri'
gem 'attribute_normalizer', github: 'mdeering/attribute_normalizer'
gem 'rails-observers'
gem 'mini_magick'
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'glipper', github: 'cimon-io/glipper'

gem 'premailer-rails'
gem 'nokogiri'

gem 'sidekiq'
gem 'sidetiq'
gem 'sidekiq-limit_fetch'
gem 'sinatra', require: false # required for the sidekiq

# group :assets do
# rails 4 doesn't support assets group
gem 'fontcustom'
gem 'sass', '3.4.1'
gem 'sass-rails', '~> 5.0.0.beta1'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'uglifier'
gem 'bootstrap-sass'
gem 'jquery-fileupload-rails'
gem 'underscore-rails'
gem 'ejs'
gem 'wiskey', github: 'cimon-io/wiskey'
gem 'liqueur', github: 'cimon-io/liqueur'
# end

gem 'menuseful', github: 'cimon-io/menuseful'
gem 'susanin', github: 'cimon-io/susanin'

group :doc do
  gem 'sdoc', require: false
end

group :development do
  gem 'spring'
  gem 'thin'
  gem 'parallel_tests'
  gem 'quiet_assets'
  gem 'haml-rails'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry', require: false
  gem 'pry-nav', require: false
  gem 'pry-doc', require: false

  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'spring-commands-rspec'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'poltergeist'
  gem 'site_prism', github: 'natritmeyer/site_prism', branch: 'master'
  gem 'email_spec'
  gem 'webmock'
end

group :production do
  gem 'unicorn'
  gem 'rails_12factor'
  gem 'therubyracer', require: 'v8'
  gem 'newrelic_rpm'
end
