module UserIdentities
  module Facebook
    extend ActiveSupport::Concern

    included do
      self::PROVIDERS << :facebook
    end

    module ClassMethods
      def build_with_omniauth_facebook(auth)
        self.new(
          provider: auth['provider'],
          uid: auth['uid'],
          name: auth['info']['name'],
          name: auth['info']['nickname'],
          avatar_url: auth['info']['image'],
          email: auth['info']['email'],
          token: auth['credentials']['token']
        )
      end

      def update_with_omniauth_facebook(resource, auth)
        resource.update(
          name: auth['info']['name'],
          name: auth['info']['nickname'],
          avatar_url: auth['info']['image'],
          email: auth['info']['email'],
          token: auth['credentials']['token']
        )
      end
    end

  end
end
