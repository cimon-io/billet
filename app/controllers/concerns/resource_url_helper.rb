module ResourceUrlHelper
  extend ActiveSupport::Concern

  included do
    hide_action :polymorphic_url
    helper_method :polymorphic_url
  end

  class Resource

    def initialize(values={}, default = ->(resource) { resource })
      @resources = values.dup
      @resources.default = default
    end

    def get(record)
      @resources[record.class][record]
    end

  end

  module ClassMethods
    def polymorphic_url_prefix(content = nil)
      content_proc = if block_given?
                       Proc.new
                     else
                       Proc.new { content }
                     end
      define_method :polymorphic_url_prefix do
        @polymorphic_url_prefix ||= Resource.new(*Array.wrap(instance_exec(&content_proc)))
      end
    end
  end

  def polymorphic_url(record_or_hash_or_array, options={})
    parameters = Array.wrap(record_or_hash_or_array).map {|i| polymorphic_url_prefix.get(i) }.flatten
    super(parameters, options)
  end

  def polymorphic_url_prefix
    @polymorphic_url_prefix ||= Resource.new()
  end

end
