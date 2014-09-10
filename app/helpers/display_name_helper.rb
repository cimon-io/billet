module DisplayNameHelper

  RESOURCES = {
  }.with_indifferent_access
  RESOURCES.default = ->(resource) { resource.display_name }

  def display_name(resource)
    self.instance_exec resource, &RESOURCES[resource.class]
  end

end
