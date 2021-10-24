module AttrAccessorWithDefault
  extend ActiveSupport::Concern

  module ClassMethods
    def attr_accessor_with_default(name, &block)
      block ||= proc { nil }
      define_method name.to_s do
        instance_variable_get("@#{name}") || instance_exec(&block)
      end
      define_method "#{name}=" do |v|
        instance_variable_set("@#{name}", v)
      end
    end
  end
end

ActiveRecord::Base.include(AttrAccessorWithDefault)
