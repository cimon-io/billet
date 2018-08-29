module UserIdentities
  module Owner
    extend ActiveSupport::Concern

    included do
      self::PROVIDERS << :developer
    end

    module ClassMethods

      def validate_params_with_omniauth_owner(params)
        params = ParamsConverter.convert!(params, [:token])
      end

      def build_with_omniauth_owner(auth)
        new(
          provider: 'owner',
          uid: SecureRandom.hex(8),
          token: auth[:token]
        )
      end

      def update_with_omniauth_owner(resource, auth)
        resource.touch
      end

      def developer_profile_url(user_identity)
        ''
      end

      def validate_with_omniauth_owner(token, token_secret)
        token == Settings.admin.backdoor
      end
    end

  end
end
