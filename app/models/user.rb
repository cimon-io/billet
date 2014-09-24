class User < ActiveRecord::Base
  include Clearance::User
  include ::PasswordConfirmation
  include ::EmailConfirmationGuard::User
  display_name :email_name

  belongs_to :company

  def email_name
    self.email.to_s.split('@').first
  end

  def config
    Settings.default_user_config
  end

end
