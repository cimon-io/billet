# frozen_string_literal: true

module FlashHelper
  # flash_styleclass(:notice)
  # flash_styleclass[:notice]
  # flash_styleclass(:info)
  # flash_styleclass[:info]
  def flash_styleclass(key = nil)
    default_keys = {
      notice: 'info',
      alert: 'danger',
      errors: 'danger'
    }.with_indifferent_access

    key ? default_keys[key] : ->(k) { default_keys[k] || k }
  end

  def flash_button_tag
    content_tag(:button, '&times;'.html_safe, class: 'close', type: 'button', 'aria-hidden' => 'true', data: { dismiss: 'alert' })
  end
end
