module GlipperHelper

  protected def glip(resource)
    ApplicationDrapper.decorate(resource, self)
  end

end
