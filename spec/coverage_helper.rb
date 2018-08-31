require 'simplecov'
require 'rspec/simplecov'

if ENV['COVERAGE'] || ENV['COVERAGE_REPORT']
  SimpleCov.minimum_coverage 82.68

  formats = []
  formats << SimpleCov::Formatter::Console
  formats << SimpleCov::Formatter::HTMLFormatter if ENV['COVERAGE_REPORT']
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(formats)

  SimpleCov.start do
    add_filter 'lib/tasks'
    add_filter 'spec'
    add_filter 'config'

    # add_group 'ENGINE_NAME', 'apps/ENGINE_NAME'

    add_group 'Models', 'app/models'
    add_group 'Jobs', 'app/jobs'
    # add_group 'Reports', 'app/reports'
    # add_group 'Services', 'app/services'
    # add_group 'Webhooks', 'app/webhooks'
    # add_group 'Importer', 'app/importer'
    # add_group 'Exporter', 'app/exporter'

    add_group 'Abilities', [
      'app/abilities'
      # 'apps/ENGINE_NAME/app/abilities',
    ]

    add_group 'Libs', 'lib'
  end
  RSpec::SimpleCov.start
  Rails.application.eager_load!
end
