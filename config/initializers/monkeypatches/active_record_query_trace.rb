# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

if Rails.const_defined?(:ActiveRecordQueryTrace)
  ActiveRecordQueryTrace.enabled = ActiveRecord::Type::Boolean.new.cast(ENV.fetch('ACTIVE_RECORD_QUERY_TRACE_ENABLED', false))
  ActiveRecordQueryTrace.level = ENV.fetch('ACTIVE_RECORD_QUERY_TRACE_LEVEL', 'app').to_sym
  ActiveRecordQueryTrace.lines = ENV.fetch('ACTIVE_RECORD_QUERY_TRACE_LINES', 3).to_i
  ActiveRecordQueryTrace.colorize = ENV.fetch('ACTIVE_RECORD_QUERY_TRACE_COLORIZE', 'light purple')
end
