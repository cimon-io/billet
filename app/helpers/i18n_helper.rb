module I18nHelper

  # TODO: move such methods into the drapper
  def human_attribute_name(object, attr_name, options={})
    return object.human_attribute_name(attr_name, options) if object.respond_to? :human_attribute_name
    return human_attribute_name(object.object, attr_name, options) if object.respond_to? :object
    return human_attribute_name(object.to_s.classify.constantize, attr_name, options) if object.is_a?(Symbol)
    return human_attribute_name(object.class, attr_name, options) if object.class.respond_to? :human_attribute_name
    return attr_name
  end
  alias_method :ha, :human_attribute_name

  # TODO: move such methods into the drapper
  def plur(object, count=2)
    return object.model_name.human(count: count) if object.respond_to? :model_name
    return plur(object.object, attr_name, options) if object.respond_to? :object
    return plur(object.to_s.classify.constantize, attr_name, options) if object.is_a?(Symbol)
    return plur(object.class, attr_name, options) if object.class.respond_to? :human_attribute_name
  end
  alias_method :pl, :plur

  # TODO: move such methods into the drapper
  def custom_number_to_percentage(number, config=current_config)
    content_tag :span, class: 'percentage' do
      number_to_percentage number, precision: 1, format: config.percentage_format
    end
  end
  alias_method :ntp, :custom_number_to_percentage

  def translate(key, options = {})
    lookup_keys = scope_keys_by_controller(key.to_s, options.delete(:lookup))
    if options.delete(:html)
      lookup_keys = lookup_keys.flat_map {|k| ["#{k}.html", k]}
    end
    lookup_keys.map!(&:to_sym)
    super(
      lookup_keys[0],
      options.reverse_merge(default_interpolations(options)).merge(
        default: lookup_keys[1..-1] + Array.wrap(options[:default])
      )
    )
  end
  alias_method :t, :translate

  def translate_with_html(key, options = {})
    translate(key, options.reverse_merge(html: true))
  end
  alias_method :th, :translate_with_html

  private def scope_keys_by_controller(key, custom_lookup_context=nil)
    letter, rest = key[0], key[1..-1]
    if letter.first == "#"
      if custom_lookup_context
        Array.wrap(custom_lookup_context).map { |cp|
          cp.gsub(%r{/_?}, ".") + '.' + rest
        }
      elsif lookup_context
        lookup_context.prefixes.map { |cp|
          cp.gsub(%r{/_?}, ".") + '.' + rest
        }
      else
        raise "Cannot use t(#{key.inspect}) shortcut because path is not available"
      end
    else
      Array.wrap(key)
    end
  end

  private def default_interpolations(options)
    model_name = options.delete(:model) || controller_name
    {
      :model => model_name.singularize,
      :models => model_name.pluralize,
      :Model => model_name.singularize.titleize,
      :Models => model_name.pluralize.titleize
    }
  end

end
