# frozen_string_literal: true

module I18nHelper
  def plur(object, count = 2)
    return object.model_name.human(count: count) if object.respond_to?(:model_name)
    return plur(object.object, attr_name, options) if object.respond_to?(:object)
    return plur(object.to_s.classify.constantize, attr_name, options) if object.is_a?(Symbol)
    return plur(object.class, attr_name, options) if object.class.respond_to?(:human_attribute_name)
  end
  alias pl plur

  def translate_with_lookup(key, options = {})
    options = options.dup.reverse_merge(html: true)

    key, *defaults = scope_keys_by_controller_with_html(key, options).map!(&:to_sym)

    translate(
      key,
      default_interpolations(options).merge(
        default: [*defaults, *options.delete(:default)],
        **options
      )
    )
  end
  alias t translate_with_lookup
  alias th translate_with_lookup

  private

  def scope_keys_by_controller_with_html(key, options)
    result = scope_keys_by_controller(key.to_s, options.delete(:lookup))
    return result unless options.delete(:html)

    result.flat_map { |k| ["#{k}.html", k] }
  end

  def scope_keys_by_controller(key, custom_lookup_context = nil)
    return Array.wrap(key) unless key.starts_with?('#')

    rest = key[1..-1]

    if custom_lookup_context
      resolved_context(custom_lookup_context, rest)
    elsif lookup_context
      resolved_context(lookup_context.prefixes, rest)
    else
      raise "Cannot use t(#{key.inspect}) shortcut because path is not available"
    end
  end

  def resolved_context(custom_lookup_context, rest)
    Array.wrap(custom_lookup_context).map do |cp|
      "#{cp.gsub(%r{/_?}, '.')}.#{rest}"
    end
  end

  def default_interpolations(options)
    model_name = model_name_struct(options)

    {
      model: model_name.model,
      models: model_name.models,
      Model: model_name.model.titleize,
      Models: model_name.models.titleize
    }
  end

  def model_name_struct(options)
    name = resolved_model_name(options)

    if name
      OpenStruct.new(model: name.singular, models: name.plural)
    else
      OpenStruct.new(model: controller_name, models: controller_name.pluralize)
    end
  end

  def resolved_model_name(options)
    options.delete(:model) ||
      options.delete(:klass).try(:model_name) ||
      (defined?(resource_class) ? resource_class.model_name : nil)
  end
end
