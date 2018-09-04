# frozen_string_literal: true

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

    def get(key, _options)
      json[key.to_s]
    end
  end

  def compute_asset_path(source, options = {})
    ManifestFile.get(source, options)
  end
end
# rubocop:enable Style/ClassAndModuleChildren
