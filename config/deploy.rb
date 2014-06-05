set :application, 'billet'
set :repo_url, 'APPLICATION_REPO'

set :deploy_to, '/var/www/billet'
set :web_service_name, 'billet:web'
set :worker_service_name, 'billet:worker'

set :rake_cmd, 'bin/rake'
set :linked_files, %w{.env}

set :bundle_binstubs, nil

set :newrelic_revision, -> { fetch(:current_revision) }

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :sudo, '/usr/bin/supervisorctl', 'restart', fetch(:web_service_name)
      execute :sudo, '/usr/bin/supervisorctl', 'restart', fetch(:worker_service_name)
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after 'deploy:publishing', 'deploy:restart'
  after :finishing, 'deploy:cleanup'
  before :finished, 'newrelic:notice_deployment'

end
