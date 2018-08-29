RSpec.configure do |config|
  def sign_in(user = double('user'))
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    allow_any_instance_of(ApplicationController).to receive(:signed_in?).and_return(true)
  end

  def sign_out
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
    allow_any_instance_of(ApplicationController).to receive(:signed_in?).and_return(false)
  end
end
