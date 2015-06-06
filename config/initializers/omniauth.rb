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
    alias_method_chain :provider, :remembering

  end
end


Rails.application.config.middleware.use OmniAuth::Builder do

  if Settings.providers.github.key && Settings.providers.github.secret
    provider :github,
              Settings.providers.github.key,
              Settings.providers.github.secret,
              scope: "user:email"
  end

  if Settings.providers.facebook.key && Settings.providers.facebook.secret
    provider :facebook,
              Settings.providers.facebook.key,
              Settings.providers.facebook.secret,
              scope: "email"
  end

  unless Settings.providers.map(&:second).map { |k1| k1.map(&:second).all? }.any?
    provider :developer,
             fields: [:name, :email],
             uid_field: :email
  end

end
