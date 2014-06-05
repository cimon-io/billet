module BelongsDirectly
  extend ActiveSupport::Concern

  included do
    before_validation :store_directly_belong_model
  end

  module ClassMethods

    def belongs_directly_to(relation_name, _options={})
      options = _options.dup
      options[:foreign_key] ||= "#{relation_name}_id"
      options[:primary_key] ||= "id"

      define_method :store_directly_belong_model do
        relation = self.public_send(relation_name)
        self.public_send "#{options[:foreign_key]}=", relation.public_send(options[:primary_key]) if relation
      end
    end
  end

  def store_directly_belong_model
  end

end
