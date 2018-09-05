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
 - Rename default database for development and test in `config/database.yml`
 - Rename name of session store in `config/initializers/session_store.rb`

### Deploy configuration
 - Make required changes into the `config/deploy.rb` such as `application_name`, `repo_url` so on
 - Set correct IPs for the production and staging environment inside `config/deploy/production.rb` and `config/deploy/staging.rb`

### Various configs
 - Rename application and and other project based config values in `config/settings.yml`
 - Rename application name `config/newrelic.yml`
 - Rename application in the first line of `README.md`
 - Add description to the 'Synopsis' section
 - Change production domain in 'Synopsis' section

### Database seeding
 - Edit `db/seed.rb` to fill database automaticaly (especially email of single user)

### Remove this documentation
 - This documentation is not required for your project, thus just remove section 'How to use it'

# Synopsis
*Describe your project here*

* Production site: https://example.com

## Initial setup

Install another dependencies from `Brewfile` via

```console
$ brew bundle
```

Run

```console
$ gem update --system 2.6.11
$ rbenv rehash
$ bundle
$ bin/rake db:create db:migrate db:seed
```

This will set up the database and populate it with initial data.

## Run application

Foreman is able to run everything whats needed via single command. Check `Procfile` to read more:

```console
foreman start
```

Application uses webpack to build css/js files. Run it via:

```console
bin/assets
```

Or using `foreman`:

```console
foreman start assets
```

Then run rails server:

```console
bin/rails s -b 0.0.0.0
```

Or using `foreman`:

```console
foreman start web
```

`lvh.me` is the default domain, configured in example
configuration files. Use `lvh.me:3000` and its subdomains
to access the application in development.

In addition, to run the background jobs process run the following:

```console
./bin/sidekiq -C config/sidekiq.yml
```

Or using `foreman`:

```console
foreman start worker
```

That's it.

## Run tests

* Make sure you've run `bin/rake db:migrate RAILS_ENV=test`
* Running `bin/rake` will run unit tests, then, if all pass, run acceptance
  tests
* We do unit testing with rspec. To run just unit tests run `bin/rake spec`.
  To run a single one, run `bin/rspec spec/path/to/spec.rb`.
* To run rubocop, just `bin/rubocop`. Do not forget to do it before commit.
* `bin/brakeman` checks code for security vulnerabilities.
