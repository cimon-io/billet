module MenuItem
  extend ActiveSupport::Concern

  included do
    helper_method :menu_item
    hide_action :menu_item
  end

  module ClassMethods
    def menu_item(*args)
      item_proc = if block_given?
                    Proc.new
                  else
                    Proc.new { args }
                  end
      define_method :menu_item do
        @menu_item ||= Item.new(*instance_exec(&item_proc))
      end
    end
  end

  class Item
    attr_accessor :trail

    def initialize(*args)
      self.trail = args.flatten.map(&:to_s)
    end

    def is?(*pattern_trail)
      raise ArgumentError, "Can't compare without any arguments." unless pattern_trail.present?
      trail.take(pattern_trail.length) == pattern_trail.map(&:to_s)
    end
    alias_method :sub?, :is?

  end

  def menu_item
    Item.new
  end
end
