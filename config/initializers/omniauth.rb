OmniAuth.config.logger = Rails.logger

module OmniAuth
  class Builder < ::Rack::Builder
    class << self
      def providers
        @@providers || []
      end
    end

    def provider_with_remembering(klass, *args, &block)
      @@providers ||= []
      @@providers << klass
      provider_without_remembering(klass, *args, &block)
    end
    alias provider_without_remembering provider
    alias provider provider_with_remembering
  end
end

# rubocop:disable Metrics/BlockLength
Rails.application.config.middleware.insert_before Authenticator::Middleware, OmniAuth::Builder do
  if Settings.providers.facebook.key && Settings.providers.facebook.secret
    provider :facebook,
             Settings.providers.facebook.key,
             Settings.providers.facebook.secret,
             scope: "email",
             image_size: {
               width: 300,
               height: 300
             }
  end

  if Settings.providers.twitter.key && Settings.providers.twitter.secret
    provider :twitter,
             Settings.providers.twitter.key,
             Settings.providers.twitter.secret,
             scope: "email",
             image_size: 'original'
  end

  if Settings.providers.instagram.key && Settings.providers.instagram.secret
    provider :instagram,
             Settings.providers.instagram.key,
             Settings.providers.instagram.secret
  end

  if Settings.providers.tumblr.key && Settings.providers.tumblr.secret
    provider :tumblr,
             Settings.providers.tumblr.key,
             Settings.providers.tumblr.secret
  end

  if Settings.providers.map(&:second).map { |k1| k1.map(&:second).all? }.none? || Settings.providers.developer.allow
    provider :developer,
             fields: [:name, :email],
             uid_field: :email
  end
end
# rubocop:enable Metrics/BlockLength
