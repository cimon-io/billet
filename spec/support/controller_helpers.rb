module ControllerHelpers
  def sign_in(user = double('user'))
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    allow_any_instance_of(ApplicationController).to receive(:signed_in?).and_return(true)
  end
end