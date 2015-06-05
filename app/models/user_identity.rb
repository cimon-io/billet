class UserIdentity < ActiveRecord::Base
  has_paper_trail

  belongs_to :user

  scope :with_default_order, -> { order(created_at: :asc) }

  PROVIDERS = []
  include UserIdentities::Developer if OmniAuth::Builder.providers.include?(:developer)
  include UserIdentities::Facebook if OmniAuth::Builder.providers.include?(:facebook)
  include UserIdentities::Github if OmniAuth::Builder.providers.include?(:github)

  class << self

    def omniauthable?(auth)
      PROVIDERS.include?(auth['provider'].to_sym)
    end

    def find_with_omniauth(auth)
      self.find_by(uid: auth['uid'], provider: auth['provider'])
    end

    def create_with_omniauth(auth, user)
      self.public_send("build_with_omniauth_#{auth['provider']}", auth).tap do |ui|
        user ? ui.user = user : ui.build_user
        ui.save
      end
    end

    def update_with_omniauth(resource, auth)
      self.public_send("update_with_omniauth_#{auth['provider']}", resource, auth)
      resource
    end

    def find_or_create_with_omniauth(auth, user=nil)
      raise ActiveRecord::RecordNotFound unless omniauthable?(auth)
      resource = find_with_omniauth(auth).tap { |ui| self.update_with_omniauth(ui, auth) if ui } || self.create_with_omniauth(auth, user)
    end
  end

end
