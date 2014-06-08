module PasswordConfirmation
  extend ActiveSupport::Concern

  included do
    validates :password, confirmation: true
    validates :password_confirmation, presence: true, if: ->(u) { u.encrypted_password_changed? }
  end

end
