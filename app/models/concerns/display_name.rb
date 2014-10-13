module DisplayName
  extend ActiveSupport::Concern

  module ClassMethods
    def display_name(method_symbol=nil)
      if block_given?
        define_method :__display_name, &Proc.new
      elsif method_symbol
        # alias_method :__display_name, method_symbol
        define_method :__display_name do
          self.public_send method_symbol
        end
      else
        raise "And what would you like me to do?" # or noop
      end
    end
  end

  def display_name
    __display_name.presence || display_name_guess
  end

  def __display_name
    nil
  end

  def display_name_guess
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
