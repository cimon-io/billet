class User < ActiveRecord::Base
  include Clearance::User
  include ::PasswordConfirmation
  include ::EmailConfirmationGuard::User

  belongs_to :company

  def config
    Settings.default_user_config
  end

end
