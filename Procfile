web: bin/puma -p ${PORT:-3000} -e ${RACK_ENV:-development} -C config/puma.rb
worker: bin/sidekiq -C config/sidekiq.yml
rpc: bin/anycable
ws: anycable-go --host=localhost --port=3334 -headers=cookie,Authorization,origin
