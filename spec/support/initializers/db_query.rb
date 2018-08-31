# frozen_string_literal: true

DBQueryMatchers.configure do |config|
  config.ignores = [/SHOW TABLES LIKE/]
  config.schemaless = true

  config.log_backtrace = true
  config.backtrace_filter = proc do |backtrace|
    backtrace.select { |line| line.start_with?(Rails.root.to_s) }
  end
end
