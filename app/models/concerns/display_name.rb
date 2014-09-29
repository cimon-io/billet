module DisplayName
  extend ActiveSupport::Concern

  module ClassMethods
    def display_name(alias_method=nil)
      define_method(:display_name) do
        content_proc = block_given? ? Proc.new : Proc.new { self.public_send(alias_method) }
        instance_exec(&content_proc).presence || self.display_name_backward
      end
    end
  end

  def display_name
    self.display_name_backward
  end

  def display_name_backward
    self.public_send(self.display_name_assumption)
  end

  def display_name_assumptions
    %w{full_name name title subject display_name_default}
  end

  def display_name_assumption
    Array.wrap(self.display_name_assumptions).find do |method_name|
      self.respond_to?(method_name) && self.public_send(method_name)
    end
  end

  def display_name_default
    self.id ? "#{self.class.model_name.human} #{self.id}" : "New #{self.class.model_name.human}"
  end

end
