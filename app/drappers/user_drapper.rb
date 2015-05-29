class UserDrapper < ApplicationDrapper
  decorates User

  def blank_display_name
    self.email.to_s.split('@').first
  end

end
