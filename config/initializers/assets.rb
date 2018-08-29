# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
# Rails.application.config.assets.version = '1.0'
# Rails.application.config.assets.manifest = 'public/assets/manifest.json'

# # Add additional assets to the asset load path
# # Rails.application.config.assets.paths << Emoji.images_path

# # Precompile additional assets.
# # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# # Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.prefix = ENV.fetch('WEB_ASSETS_DIR', '/web-assets')
Rails.application.config.asset_host = ENV.fetch('WEB_ASSETS_HOST', 'http://lvh.me:3000')

require 'singleton'
require 'json'

module ActionView::Helpers::AssetUrlHelper

  class ManifestFile
    include Singleton

    class << self
      def get(*args)
        self.instance.get(*args)
      end
    end

    def initialize()
      @source = Rails.root.join("public" + Rails.application.config.assets.prefix + "/manifest.json")
    end

    def json
      JSON.parse(File.read(@source)).stringify_keys
    end

    TYPE_PREFIXES = {
      javascript: 'javascripts',
      stylesheet: 'stylesheets',
      image: 'images',
      video: 'videos',
      audio: 'audios',
      font: 'fonts',
      file: 'files'
    }.freeze

    def get(key, options)
      json["#{key}"]
    end
  end

  def compute_asset_path(source, options = {})
    ManifestFile.get(source, options)
  end
end
