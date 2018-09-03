# frozen_string_literal: true

require 'rake'

module TaskExampleGroup
  extend ActiveSupport::Concern

  included do
    let(:tasks) { Rake::Task }
    let(:task_name) { self.class.top_level_description.sub(/\Arake /, '') }
    subject(:task) { tasks[task_name] }
  end
end

RSpec.configure do |config|
  # Tag Rake specs with `:task` metadata or put them in the spec/tasks dir
  config.define_derived_metadata(file_path: %r{/spec/tasks/}) do |metadata|
    metadata[:type] = :task
  end

  config.include TaskExampleGroup, type: :task

  config.before(:suite) do
    Rails.application.load_tasks
  end
end
