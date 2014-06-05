set :stage, :production
set :branch, :master

role :app, %w{deploy@XXX.XXX.XXX.XXX}
role :web, %w{deploy@XXX.XXX.XXX.XXX}
role :db,  %w{deploy@XXX.XXX.XXX.XXX}, primary: true
