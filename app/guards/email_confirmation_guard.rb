class EmailConfirmationGuard < Clearance::SignInGuard

  module User
    extend ActiveSupport::Concern

    included do
      before_create :generate_confirmation_token
    end

    def confirm!
      self.confirmation_token = nil
      self.confirmed_at = Time.current
      save validate: false
    end

  end

  def call
    if unconfirmed?
      failure("You must confirm your email address.")
    else
      next_guard
    end
  end

  protected

  def unconfirmed?
    signed_in? && !current_user.confirmed_at && current_user.created_at < Settings.unconfirmed_days.days.ago
  end

end
