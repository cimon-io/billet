module BooleanHelper

  def boolean_tag(condition, &block)
    true_value = block_given? ? Proc.new : Proc.new { concat icon_tag(:ok) }
    condition ? capture(&true_value) : icon_tag(:minus)
  end
  alias_method :b, :boolean_tag

end
