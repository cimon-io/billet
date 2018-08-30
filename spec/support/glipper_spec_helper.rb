RSpec.configure do |_config|
  def glip(resource)
    ApplicationDrapper.decorate(resource)
  end
end
