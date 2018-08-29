module UserIdentities
  module Instagram
    extend ActiveSupport::Concern

    included do
      self::PROVIDERS << :instagram
    end

    module ClassMethods
      def validate_params_with_omniauth_instagram(params)
        params = ParamsConverter.convert!(params, [:info, :credentials, :uid, :provider])
        params[:info] = ParamsConverter.convert!(params[:info], [:name])
        params[:credentials] = ParamsConverter.convert!(params[:credentials], [:token])
        params
      end

      def build_with_omniauth_instagram(auth)
        new(
          provider: auth[:provider],
          uid: auth[:uid],
          name: auth[:info][:name],
          avatar_url: auth[:info][:image],
          email: auth[:info][:email],
          token: auth[:credentials][:token]
        )
      end

      def update_with_omniauth_instagram(resource, auth)
        resource.update(
          name: auth[:info][:nickname],
          avatar_url: auth[:info][:image],
          email: auth[:info][:email],
          token: auth[:credentials][:token]
        )
      end

      def instagram_profile_url(user_identity)
        "http://instagram.com/#{user_identity.uid}"
      end

      def validate_with_omniauth_instagram(token, token_secret)
        RestClient.get("https://api.instagram.com/v1/users/self", params: { access_token: token })
        true
      rescue RestClient::BadRequest => e
        false
      end
    end
  end
end
