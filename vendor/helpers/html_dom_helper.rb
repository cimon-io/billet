# frozen_string_literal: true

module HtmlDomHelper
  # rubocop:disable Metrics/PerceivedComplexity
  def dom_id(*args)
    args.map do |a|
      if a.is_a?(Class)
        dom_class(a)
      elsif a.is_a?(Integer) && args.size > 1 && !args.first.is_a?(Integer)
        a.to_s
      elsif a.respond_to?(:id)
        if a.id
          "#{dom_class(a)}_#{a.id}"
        else
          "#{dom_class(a)}_new"
        end
      elsif a.respond_to?(:to_sym)
        a.to_sym
      elsif a.respond_to?(:to_key)
        a.to_key
      else
        a.object_id
      end
    end.join('-')
  end
  # rubocop:enable Metrics/PerceivedComplexity

  def css_id(*args)
    "##{dom_id(*args)}"
  end

  def dom_klass(resource, options = {})
    glip(resource).dom_klass(options)
  end

  def collection_class(resource_class)
    "#{resource_class.model_name.plural}-list"
  end
end
