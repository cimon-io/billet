# frozen_string_literal: true

# supported_version: Rails::VERSION::STRING '~> 7.0.0.alpha2'

require 'singleton'
require 'json'

# rubocop:disable Style/ClassAndModuleChildren
module ActionView::Helpers::AssetUrlHelper
  class ManifestFile
    include Singleton

    class << self
      def get(*args)
        instance.get(*args)
      end
    end

    def initialize
      @source = Rails.root.join('public', ENV.fetch('WEB_ASSETS_DIR', 'web-assets').sub(%r{\A/}, ''), 'manifest.json')
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

    def get(key, _options)
      json[key.to_s]
    end
  end

  def compute_asset_path(source, options = {})
    ManifestFile.get(source, options)
  end
end
# rubocop:enable Style/ClassAndModuleChildren
