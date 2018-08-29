module UserIdentities
  module Facebook
    extend ActiveSupport::Concern

    included do
      self::PROVIDERS << :facebook
    end

    module ClassMethods
      def validate_params_with_omniauth_facebook(params)
        params = ParamsConverter.convert!(params, [:info, :credentials, :uid, :provider])
        params[:info] = ParamsConverter.convert!(params[:info], [:name])
        params[:credentials] = ParamsConverter.convert!(params[:credentials], [:token])
        params
      end

      def build_with_omniauth_facebook(auth)
        new(
          provider: auth[:provider],
          uid: auth[:uid],
          name: auth[:info][:name],
          avatar_url: auth[:info][:image],
          email: auth[:info][:email],
          token: auth[:credentials][:token]
        )
      end

      def update_with_omniauth_facebook(resource, auth)
        resource.update(
          name: auth[:info][:name],
          avatar_url: auth[:info][:image],
          email: auth[:info][:email],
          token: auth[:credentials][:token]
        )
      end

      def facebook_profile_url(user_identity)
        "http://www.facebook.com/#{user_identity.uid}"
      end

      def validate_with_omniauth_facebook(token, token_secret)
        RestClient.get("https://graph.facebook.com/me", params: { access_token: token })
        true
      rescue RestClient::BadRequest => e
        false
      end
    end
  end
end
