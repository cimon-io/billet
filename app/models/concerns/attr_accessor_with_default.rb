module AttrAccessorWithDefault
  extend ActiveSupport::Concern

  module ClassMethods
    def attr_accessor_with_default(name)
      content_proc = block_given? ? Proc.new : proc { nil }
      define_method "#{name}" do
        instance_variable_get("@#{name}") || instance_exec(&content_proc)
      end
      define_method "#{name}=" do |v|
        instance_variable_set("@#{name}", v)
      end
    end
  end
end
