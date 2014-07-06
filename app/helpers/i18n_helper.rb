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

  def translate_general(kind, key, options)
    html = options.delete(:html) ? :html : nil
    scope = options.delete(:scope).to_s
    default_options = {
      :model => scope.singularize,
      :models => scope.pluralize,
      :Model => scope.singularize.titleize,
      :Models => scope.pluralize.titleize
    }


    key_with_scope = [kind, scope, *key.to_s.split('.'), html].compact.join('.').to_sym
    default_key_with_scope = [kind, 'defaults', *key.to_s.split('.'), html].compact.join('.').to_sym

    translate key_with_scope, default_options.merge(default: default_key_with_scope).merge(options)
  end

  def translate_helper(key, options={})
    translate_general :helpers, key, ({html: true}).merge(options)
  end
  alias_method :th, :translate_helper

  def translate_views(key, options={})
    translate_general :views, key, ({html: false}).merge(options)
  end
  alias_method :tv, :translate_views

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

end
