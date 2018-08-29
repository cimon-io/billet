class UserIdentity < ApplicationRecord
  has_paper_trail

  serialize :raw_data, Hash
  def raw_data; super.with_indifferent_access; end

  belongs_to :user

  validates :token, token: true

  scope :with_default_order, -> { order(created_at: :asc) }
  scope :social_networks, -> { where(provider: [:twitter, :facebook, :instagram, :tumblr]) }

  PROVIDERS = []
  include UserIdentities::Owner
  include UserIdentities::Developer if OmniAuth::Builder.providers.include?(:developer)
  include UserIdentities::Facebook if OmniAuth::Builder.providers.include?(:facebook)
  include UserIdentities::Twitter if OmniAuth::Builder.providers.include?(:twitter)
  include UserIdentities::Instagram if OmniAuth::Builder.providers.include?(:instagram)
  include UserIdentities::Tumblr if OmniAuth::Builder.providers.include?(:tumblr)

  class << self
    def omniauthable?(auth)
      PROVIDERS.include?(auth[:provider].to_sym)
    end

    def find_with_omniauth(auth)
      self.find_by(uid: auth[:uid], provider: auth[:provider])
    end

    def validate_params_with_omniauth(auth)
      self.public_send("validate_params_with_omniauth_#{auth[:provider]}", auth)
    end

    def create_with_omniauth(auth, user)
      self.public_send("build_with_omniauth_#{auth[:provider]}", auth).tap do |ui|
        user ? ui.user = user : ui.build_user(nickname: ui.name)
        ui.raw_data = auth
        ui.save
      end
    end

    def update_with_omniauth(resource, auth)
      self.public_send("update_with_omniauth_#{auth[:provider]}", resource, auth)
      resource
    end

    def find_or_create_with_omniauth(auth, user=nil)
      raise ActiveRecord::RecordNotFound unless omniauthable?(auth)
      auth = validate_params_with_omniauth(auth)
      resource = find_with_omniauth(auth).tap { |ui| self.update_with_omniauth(ui, auth) if ui } || self.create_with_omniauth(auth, user)
    end
  end

  def profile_url
    self.class.public_send(profile_url_method_name, self)
  end

  private def profile_url_method_name
    "#{provider}_profile_url"
  end
end
