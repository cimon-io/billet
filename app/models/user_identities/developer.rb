module UserIdentities
  module Developer
    extend ActiveSupport::Concern

    included do
      self::PROVIDERS << :developer
    end

    module ClassMethods
      def validate_params_with_omniauth_developer(params)
        params = ParamsConverter.convert!(params, [:info, :uid, :provider])
        params[:info] = ParamsConverter.convert!(params[:info], [:name], [:email])
        params
      end

      def build_with_omniauth_developer(auth)
        new(
          provider: auth[:provider],
          uid: auth[:uid],
          name: auth[:info][:name],
          email: auth[:info][:email],
          avatar_url: "#{Settings.application.domain}#{Settings.application.assets_prefix}/default-avatar.png"
        )
      end

      def update_with_omniauth_developer(resource, auth)
        resource.update(
          name: auth[:info][:name],
          email: auth[:info][:email]
        )
      end

      def developer_profile_url(user_identity)
        ''
      end

      def validate_with_omniauth_developer(token, token_secret)
        true
      end
    end
  end
end
