module BelongsDirectly
  extend ActiveSupport::Concern

  module ClassMethods
    def belongs_directly_to(relation_name, options = {})
      define_method "store_directly_#{relation_name}_belong_model" do
        foreign_key = options.key?(:foreign_key) ? options[:foreign_key] : "#{relation_name}_id"
        primary_key = options.key?(:primary_key) ? options[:primary_key] : "id"
        relation = public_send(relation_name)
        public_send "#{foreign_key}=", relation.public_send(primary_key) if relation
      end

      before_validation "store_directly_#{relation_name}_belong_model"
    end
  end
end

ActiveRecord::Base.send :include, BelongsDirectly
