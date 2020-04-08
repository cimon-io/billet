# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end

ActionController::Renderers.add :css do |_obj, _options|
  send_data Sass.compile(render_to_string, cache: false, style: (Rails.env.production? ? :compressed : :nested)), type: Mime[:css], disposition: nil
end
