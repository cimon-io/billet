module UserIdentities
  module Twitter
    extend ActiveSupport::Concern

    included do
      self::PROVIDERS << :twitter
    end

    module ClassMethods
      def validate_params_with_omniauth_twitter(params)
        params = ParamsConverter.convert!(params, [:info, :credentials, :uid, :provider])
        params[:info] = ParamsConverter.convert!(params[:info], [:name])
        params[:credentials] = ParamsConverter.convert!(params[:credentials], [:token, :secret])
        params
      end

      def build_with_omniauth_twitter(auth)
        new(
          provider: auth[:provider],
          uid: auth[:uid],
          name: auth[:info][:name],
          avatar_url: auth[:info][:image],
          token: auth[:credentials][:token],
          token_secret: auth[:credentials][:secret]
        )
      end

      def update_with_omniauth_twitter(resource, auth)
        resource.update(
          name: auth[:info][:nickname],
          avatar_url: auth[:info][:image],
          token: auth[:credentials][:token],
          token_secret: auth[:credentials][:secret]
        )
      end

      def twitter_profile_url(user_identity)
        "http://www.twitter.com/#{user_identity.uid}"
      end

      def validate_with_omniauth_twitter(token, token_secret)
        client = ::Twitter::REST::Client.new(
          consumer_key: Settings.providers.twitter.key,
          consumer_secret: Settings.providers.twitter.secret,
          access_token: token,
          access_token_secret: token_secret
        )
        client.user
        true
      rescue ::Twitter::Error::Unauthorized
        false
      end
    end
  end
end
