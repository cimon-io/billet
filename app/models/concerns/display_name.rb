module DisplayName
  extend ActiveSupport::Concern

  module ClassMethods
    def display_name(alias_method)
      define_method(:display_name) do
        self.public_send(alias_method).presence || self.default_display_name
      end
    end
  end

  def default_display_name
    return "#{self.class.model_name.human} #{self.id}" if self.id
    return "New #{self.class.model_name.human}"
  end

end
