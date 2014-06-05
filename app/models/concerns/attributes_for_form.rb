module AttributesForForm
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods

    def attributes_for_form
      result = self.attribute_names - ["id", "created_at", "updated_at"]
    end

  end

end
