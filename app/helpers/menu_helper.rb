module MenuHelper

  def link_to_menu menu_item_name, text, url, options={}
    link_to_menu_if menu_item.is?(*menu_item_name), text, url, options
  end

  def link_to_menu_if condition, text, url, options={}, &block
    classes = condition ? 'active' : ''
    icon_name = options.delete(:icon)

    icon = icon_name ? icon_tag(icon_name) : nil
    text = translate_views('menu', scope: text) if text.is_a?(Symbol)
    content = content_tag(:span, text)

    wrapper = block           if block_given?
    wrapper = -> { content }  if options.delete(:wrapper) == :none
    wrapper = -> do
      link_to url, options.merge(title: text) do
        concat icon
        concat content
      end
    end

    content_tag :li, (wrapper.call), class: classes
  end

end
