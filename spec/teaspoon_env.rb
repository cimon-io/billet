# frozen_string_literal: true

Teaspoon.configure do |config|
  config.mount_at = '/teaspoon'
  config.root = nil
  config.asset_paths = ['spec/javascripts', 'spec/javascripts/stylesheets']

  config.suite do |suite|
    # Versions: 1.3.1, 2.0.3, 2.1.3, 2.2.0, 2.2.1, 2.3.4
    suite.use_framework :jasmine, '2.3.4'
    suite.matcher = '{spec/javascripts,app/assets}/**/*_spec.{js,js.coffee,coffee}'
    # suite.javascripts = []
    # suite.stylesheets = ["teaspoon"]
    suite.helper = 'spec_helper'

    # Available: boot, boot_require_js
    suite.boot_partial = 'boot'
    suite.body_partial = 'body'
  end
end
