module I18nHelper

  def plur(object, count=2)
    return object.model_name.human(count: count) if object.respond_to? :model_name
    return plur(object.object, attr_name, options) if object.respond_to? :object
    return plur(object.to_s.classify.constantize, attr_name, options) if object.is_a?(Symbol)
    return plur(object.class, attr_name, options) if object.class.respond_to? :human_attribute_name
  end
  alias_method :pl, :plur

  def translate_with_lookup(key, options = {})
    options = options.dup.reverse_merge(html: true)

    lookup_keys = scope_keys_by_controller(key.to_s, options.delete(:lookup))
    if options.delete(:html)
      lookup_keys = lookup_keys.flat_map {|k| ["#{k}.html", k]}
    end
    lookup_keys.map!(&:to_sym)
    translate(
      lookup_keys[0],
      options.reverse_merge(default_interpolations(options)).merge(
        default: lookup_keys[1..-1] + Array.wrap(options[:default])
      )
    )
  end
  alias_method :t, :translate_with_lookup
  alias_method :th, :translate_with_lookup

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
