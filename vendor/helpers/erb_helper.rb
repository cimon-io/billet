# frozen_string_literal: true

module ErbHelper
  def e(*args, &block)
    escape_javascript(*args, &block)
  end
end
