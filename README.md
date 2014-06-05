# Billet

## How to use it.

### Initialize repo
 - Remove existing `.git` folder via `rm -rf .git`
 - Initiate new repo via `git init`
 - Add and commit all files `git add .` and `git commit -m "Initial import from billet"`
 - Add remote repository: `git remote add origin REPO_URL`
 - Push the repo 'git push -u origin master'

### Rename font
 - `app/assets/fonts/config.json` contains `name` key which should be renamed
 - open http://fontello.com and import `config.json` to generate new font
[import button](//habrastorage.org/files/e9e/15d/191/e9e15d191acc47e5b5f50bdd12ee53bc.png)
 - remove `app/assets/fonts/billet.*` font files
 - download and unzip generated font and copy font files to `app/assets/fonts`
 - create new `icons/*.scss` files based on generated font folder and `*.css` files from it

### Rename application
 - Rename module application in `config/application.rb`
 - Rename default database for development and test in `config/database.yml`
 - Rename name of session store in `config/initializers/session_store.rb`

### Deploy configuration
 - Make required changes into the `config/deploy.rb` such as `application_name`, `repo_url` so on
 - Set correct IPs for the production and staging environment inside `config/deploy/production.rb` and `config/deploy/staging.rb`

### Various configs
 - Rename application and and other project based config values in `config/settings.yml`
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

Run

```console
$ bundle
$ rbenv rehash
$ bin/rake db:create db:migrate db:seed
```

This will set up the database and populate it with initial data.

## Run application

Run the following:

```console
bin/rails s
```

`lvh.me` is the default domain, configured in example
configuration files. Use `lvh.me:3000` and its subdomains
to access the application in development.

In addition, to run the background jobs process run the following:

```console
sidekiq -C config/sidekiq.yml
```

That's it.

## Run tests

* Make sure you've run `bin/rake db:migrate RAILS_ENV=test`
* Running `bin/rake` will run unit tests, then, if all pass, run acceptance
  tests
* We do unit testing with rspec. To run just unit tests run `bin/rake spec`.
  To run a single one, run `bundle exec rspec spec/path/to/spec.rb`.
* * Parallel tests:

```console
rake parallel:create # once
rake parallel:prepare # when you have migrations
rake parallel:spec # run specs
rake parallel # you run all tests
```

## Deploying

We use Capistrano. If you are familiar with it (as you should) all is
trivial. We also use Capistrano multistaging and the default stage is
staging.

So the cheatsheet:

```console
cap staging deploy            # deploy to staging
cap production deploy         # deploy to live server
```
