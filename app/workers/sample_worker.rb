class SampleWorker
  include Sidekiq::Worker
  # include Sidetiq::Schedulable

  # sidekiq_options queue: :custom, retry: false

  # recurrence { daily }

  def perform
    puts "Place worker code here"
  end
end

# SampleWorker.perform_async
# to run worker task
