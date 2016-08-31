module UserIdentities
  module Tumblr
    extend ActiveSupport::Concern

    included do
      self::PROVIDERS << :tumblr
    end

    module ClassMethods

      def validate_params_with_omniauth_tumblr(params)
        params = ParamsConverter.convert!(params, [:info, :credentials, :uid, :provider])
        params[:info] = ParamsConverter.convert!(params[:info], [:name])
        params[:credentials] = ParamsConverter.convert!(params[:credentials], [:token])
        params
      end

      def build_with_omniauth_tumblr(auth)
        self.new(
          provider: auth[:provider],
          uid: auth[:uid],
          name: auth[:info][:name],
          avatar_url: auth[:info][:avatar],
          token: auth[:credentials][:token]
        )
      end

      def update_with_omniauth_tumblr(resource, auth)
        resource.update(
          uid: auth[:uid],
          name: auth[:info][:name],
          avatar_url: auth[:info][:avatar],
          token: auth[:credentials][:token]
        )
      end

      def validate_with_omniauth_tumblr(token, user_identity)
        # TODO
        true
      end

      def tumblr_profile_url(user_identity)
        "http://#{user_identity.uid}.tumblr.com/"
      end
    end

  end
end
