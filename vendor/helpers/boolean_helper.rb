# frozen_string_literal: true

module BooleanHelper
  def boolean_tag(condition)
    true_value = block_given? ? Proc.new : proc { concat "+" }
    condition ? capture(&true_value) : "-"
  end
  alias b boolean_tag
end
