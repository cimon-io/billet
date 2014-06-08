# in lib/clearance/password_confirmation.rb
module Clearance
  module PasswordConfirmation
    extend ActiveSupport::Concern

    included do
      validates :password, confirmation: true
      validates :password_confirmation, presence: true, if: ->(u) { u.encrypted_password_changed? }
      # attr_accessor :password_confirmation
      # before_save :validate_password_confirmation, :unless => :password_optional?
    end

    # private
    # def validate_password_confirmation
    #   unless password_confirmed?
    #     errors.add :password_confirmation, 'does not match password'
    #     return false
    #   end
    # end

    # def password_confirmed?
    #   password.present? && password == password_confirmation
    # end
  end
end
