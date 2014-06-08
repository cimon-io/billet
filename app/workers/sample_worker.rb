class SampleWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false

  def perform
    puts "Place worker code here"
  end
end

# SampleWorker.perform_async
# to run worker task