class User < ActiveRecord::Base
  include Clearance::User
  include ::PasswordConfirmation
  include ::EmailConfirmationGuard::User

  display_name { self.email.to_s.split('@').first }

  belongs_to :company

  def config
    Settings.default_user_config
  end

end
