module UserIdentities
  module Developer
    extend ActiveSupport::Concern

    included do
      self::PROVIDERS << :developer
    end

    module ClassMethods
      def build_with_omniauth_developer(auth)
        self.new(
          provider: auth['provider'],
          uid: auth['uid'],
          name: auth['info']['name'],
          email: auth['info']['email']
        )
      end

      def update_with_omniauth_developer(resource, auth)
        resource.update(
          name: auth['info']['name'],
          email: auth['info']['email']
        )
      end
    end

  end
end
