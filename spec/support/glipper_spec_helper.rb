RSpec.configure do |config|
  def glip(resource)
    ApplicationDrapper.decorate(resource)
  end
end
