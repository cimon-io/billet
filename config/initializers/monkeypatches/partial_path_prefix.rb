# supported_version: Rails::VERSION::STRING '~> 7.0.0.alpha2'

# allow to define #to_partial_path and
# it will not include the controller namespace by default
#   http://blog.obiefernandez.com/content/2012/01/rendering-collections-of-heterogeneous-objects-in-rails-32.html
# Approved by Obie Fernandez :)
ActionView::PartialRenderer.class_eval do
  private

  def merge_prefix_into_object_path(_pfx, path)
    path
  end
end
