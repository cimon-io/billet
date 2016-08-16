web: bin/puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development} -C config/puma.rb
worker: ./bin/sidekiq -C config/sidekiq.yml
