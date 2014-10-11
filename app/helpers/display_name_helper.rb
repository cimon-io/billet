module DisplayNameHelper

  RESOURCES = {
  }.with_indifferent_access
  RESOURCES.default = ->(resource) { resource.display_name }

  def display_name(resource)
    display_name_keys = ->(klass) {
      return [] if klass == ActiveRecord::Base
      display_name_keys[klass.superclass] + Array.wrap(klass)
    }
    key = display_name_keys[resource.class].find { |klass| RESOURCES.key?(klass) }
    self.instance_exec resource, &RESOURCES[key]
  end

end
