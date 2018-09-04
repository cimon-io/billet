# frozen_string_literal: true

module AttributeHelper
  def display_attribute(resource, attribute)
    value = resource.public_send(attribute)
    return value if value
    th('#not_specified')
  end

  def human_attribute_name(object, attr_name, options = {})
    return object.human_attribute_name(attr_name, options) if object.respond_to? :human_attribute_name
    return human_attribute_name(object.object, attr_name, options) if object.respond_to? :object
    return human_attribute_name(object.to_s.classify.constantize, attr_name, options) if object.is_a?(Symbol)
    return human_attribute_name(object.class, attr_name, options) if object.class.respond_to? :human_attribute_name
    attr_name
  end
  alias ha human_attribute_name
end
