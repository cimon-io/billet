module I18nHelper

  def human_attribute_name(object, attr_name, options={})
    return object.human_attribute_name(attr_name, options) if object.respond_to? :human_attribute_name
    return human_attribute_name(object.object, attr_name, options) if object.respond_to? :object
    return human_attribute_name(object.to_s.classify.constantize, attr_name, options) if object.is_a?(Symbol)
    return human_attribute_name(object.class, attr_name, options) if object.class.respond_to? :human_attribute_name
    return attr_name
  end
  alias_method :ha, :human_attribute_name

  def plur(object, count=2)
    return object.model_name.human(count: count) if object.respond_to? :model_name
    return plur(object.object, attr_name, options) if object.respond_to? :object
    return plur(object.to_s.classify.constantize, attr_name, options) if object.is_a?(Symbol)
    return plur(object.class, attr_name, options) if object.class.respond_to? :human_attribute_name
  end
  alias_method :pl, :plur

  def custom_time_ago_in_words_ago(date, user=current_user)
    config = user.try(:config).presence || ::Settings.default_user_config
    content_tag :span,
      I18n.t(:ago, sencence: time_ago_in_words(date), scope: :time_ago_in_words),
      title: I18n.l(date, format: config.date_format)
  end

  def custom_time_ago_in_words_since(date, user=current_user)
    config = user.try(:config).presence || ::Settings.default_user_config
    content_tag :span,
      I18n.t(:ago, sencence: time_ago_in_words(date), scope: :time_ago_in_words),
      data: { toggle: "tooltip", placement: "bottom" },
      title: I18n.l(date, format: config.full_date_format)
  end

  def custom_time_ago_in_words(date, user=current_user)
    return "-" if date.nil?
    date.past? ? custom_time_ago_in_words_ago(date, user) : custom_time_ago_in_words_since(date, user)
  end
  alias_method :tw, :custom_time_ago_in_words

  def translate(key, options = {})
    lookup_keys = scope_keys_by_controller(key.to_s)
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

  private def scope_keys_by_controller(key)
    letter, rest = key[0], key[1..-1]
    if letter.first == "#"
      if lookup_context
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
