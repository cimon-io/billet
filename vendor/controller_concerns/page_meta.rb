module PageMeta
  extend ActiveSupport::Concern

  included do
    initialize_meta
    helper_method :page_meta_for
  end

  module ClassMethods
    def initialize_meta
      before_action do
        @custom_meta = {
          value: ActiveSupport::HashWithIndifferentAccess.new,
          suffix: ActiveSupport::HashWithIndifferentAccess.new,
          prefix: ActiveSupport::HashWithIndifferentAccess.new
        }
      end
    end

    def meta_for(keys, content = "")
      content_proc = if block_given?
                       Proc.new
                     else
                       proc { content }
                     end

      keys = Array.wrap(keys)
      key = keys.pop
      scope = keys.pop || :value

      before_action { @custom_meta[scope][key] = instance_exec(&content_proc).presence || nil }
    end
  end

  def page_meta_for(key)
    [
      @custom_meta[:prefix][key],
      @custom_meta[:value][key],
      @custom_meta[:suffix][key]
    ].select(&:present?).join(" - ").presence
  end
end
