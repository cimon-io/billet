# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.prefix = ENV.fetch('WEB_ASSETS_DIR', '/web-assets')
Rails.application.config.asset_host = ENV.fetch('WEB_ASSETS_HOST', ENV.fetch('CIMON_DOMAIN_0', "http://lvh.me:3000"))
