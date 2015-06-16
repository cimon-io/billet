# encoding: utf-8

module DisplayNameHelper

  def display_link_to(resource, *args)
    link_to(glip(resource).display_name, [resource], *args)
  end

  def display_name(resource, options={})
    glip(resource).display_name(options)
  end
  alias_method :echo, :display_name

  def display_type(resource)
    glip(resource).display_type
  end

  def label_method
    ->(i) { display_name(i) }
  end

end
