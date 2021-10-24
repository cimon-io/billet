[![Build Status](https://travis-ci.org/cimon-io/billet.svg?branch=master)](https://travis-ci.org/cimon-io/billet)

# Billet

## How to use it.

### Initialize repo
 - Remove existing `.git` folder via `rm -rf .git`
 - Initiate new repo via `git init`
 - Add and commit all files `git add .` and `git commit -m "Initial import from billet"`
 - Add remote repository: `git remote add origin REPO_URL`
 - Push the repo `git push -u origin master`

### Rename application
 - Rename module application in `config/application.rb`
 - Rename name of module in constand definition `config/initializers/uptime.rb`
 - Rename default database for development and test in `config/database.yml`
 - Rename all names of containers and variales in `docker-compose.yml`
 - Rename name of session store in `config/initializers/session_store.rb`

### Various configs
 - Rename application and and other project based config values in `config/settings.yml`
 - Rename application in the header of `README.md`
 - Add description to the 'Synopsis' section
 - Change production domain in 'Synopsis' section

### Database seeding
 - Edit `db/seed.rb` to fill database automaticaly (especially email of single user)

### Remove this documentation
 - This documentation is not required for your project, thus just remove section 'How to use it'

# Synopsis
*Describe your project here*

* Production site: https://billet.dev

## Initial setup

 - Install required ruby version. The actual one can be found in `./.ruby-version`. Now it is `3.0.2`.
 - Install nodejs version. The actual one can be found in `./assets/.node-version`. Now it is `17.0.1`.
 - Install `yarn` package manager.

Install another dependencies from `Brewfile` via

```console
$ brew bundle
```

Install required libraries from `Gemfile` via

```console
$ bundle
```

Run database setup. This will set up the database and populate it with initial data.

```console
$ bin/rake db:create db:migrate db:seed
```

## Run application

Foreman is able to run everything whats needed via single command. Check `Procfile` to read more:

```console
foreman start
```

It runs the following processes:

 1. `web`. The http server. It can be run separately via command `bin/rails s -b 0.0.0.0`
 1. `worker`. The background job processor. Run it separately via command `bin/sidekiq -C config/sidekiq.yml`
 1. `rpc`. The part of anycable. Separate command is `bin/anycable`
 1. `ws`. The part of anycable. It is separate binary which can be run as `anycable-go --host=localhost --port=3334 -headers=cookie,Authorization,origin`

`lvh.me` is the default domain, configured in example
configuration files. Use `lvh.me:3000` and its subdomains
to access the application in development.

That's it.

## Run tests

* Make sure you've run `bin/rake db:migrate RAILS_ENV=test`
* Running `bin/rake` will run unit tests, then, if all pass, run acceptance
  tests
* We do unit testing with rspec. To run just unit tests run `bin/rake spec`.
  To run a single one, run `bin/rspec spec/path/to/spec.rb`.
* To run rubocop, just `bin/rubocop`. Do not forget to do it before commit.
* `bin/brakeman` checks code for security vulnerabilities.
* `bin/bundle audit check --update` checks public known vulnerabilities in the libraries.

## Framework changes

There are several fundamental changes and concepts were applied to the framework. Some of them work well in a vanilla Ruby on Rails application, but it is not customary to use it by default.

### Rails Engines

An application is split by engines by on controllers level only. All models should be left in `app/models`. To generate new engine use namespace generator via command `bin/rails generate namespace NamespaceName`. There are several config options available.

 - `--begin_chain current_company`. All resource controllers starts chaining with a root method where everything should be available. For example class Company has many projects, thus `current_company.projects` will be called in controller `projects_controller`.
 - `--access cancan` with options `fake`, `cancan`, `http` and `none`
 -  `--route prefix` to change route prefix where engine will be available. By default it is lowercased underscored namespace name.
 - `--api false` (or `true`). A namespace will be optimised for api only if it's `true`.

### Webpack Assets

https://github.com/cimon-io/billet-isolated-assets

### Application Settings

All configuration variables should be stored in the `config/settings.yml` file via `config` gem. Also it should define ENV variables to rewrite defaults.

### Initializers

All initializers have been split by 4 subfolders: `core`, `libs`, `concerns` and `monkeypatches`.

 - `core` folder contains rails initializers.
 - `libs` folders is for libraries and gems configuration and initializations.
 - `concerns` content patches and includes are `ActiveRecord::Base` and other base classes of rails.
 - `monkeypatches` folder contains the hard patches of ruby core, rails libraries and other low level libraries.

 ### Monkeypatches

- `action_view_assets_url_helper.rb` patches the `AssetUrlHelper` and it needs for new `assets` to find resources for `image_url` and other helpers.
- `active_record_database_statements.rb` patches ActiveRecord and it allows to use `RETURNING` statement to define postgresql procedures.

### Seed Loader


### Database Structure


### Database connection configuration

`DATABASE_URL`, `TEST_ENV_NUMBER`, `DATABASE_POOL`

### Secrets Encryption

### RETURNING method in SQL

#### `created_at` and `updated_at`


#### `_count` field


#### Belongs directly to


### Redis configuration

### Sidekiq tuning


### Attribute Normalizers

### Glipper as Decorator

`glipper` and `drappers`

### Unobtrusive Controllers

`unobtrusive_resources` with pagination

### Mute Action

`mute_action`

### Attribute accessor with default value

`attr_accessor_with_default`

### Prevent destroying records

`deny_destroy`

### Boolean checks on ActiveRecord level

`true?(value)`

### I18n

#### Pluralization

`plur`

#### Translation with lookup

`t` and `th`

#### Attribute Name

`display_attribute` and `human_attribute_name`

### Helpers

#### `data-link` attribute

`datalink` and `datalink_if`

#### Meta tags

controller method `meta_for` and helper `page_meta_for`

#### Flash

 - `flash_styleclass`
 - do not render flash if xhr

#### Escape Javascript Alias

`e`

#### Number to Percentage

`custom_number_to_percentage` with alias `ntp`

#### HTML DOM helpers

##### `collection_class`
##### `dom_id`
##### `dom_klass`
##### `css_id`

##### Markdown helpers

`markdown_to_html`, `markdown_to_html_if` and `md`

#### Smart Sentence

`smart_sentence`

#### Smart Sanitize

`smart_sanitize` and `should_sanitized?`
