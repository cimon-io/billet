module AttributesForForm
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods

    def attributes_for_form
      result = self.attribute_names - %w{ id company_id created_at updated_at encrypted_password confirmation_token remember_token confirmed_at }
    end

  end

end
