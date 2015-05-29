class ApplicationDrapper < Glipper::Base
  decorates ActiveRecord::Base

  include DisplayNameGlipper
  include TypeGlipper
  include StateMachineGlipper
  include TimestampGlipper

  def decorate(another_resource)
    ApplicationDrapper.decorate(another_resource, self.helpers)
  end

end
