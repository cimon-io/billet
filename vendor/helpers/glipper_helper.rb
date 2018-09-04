# frozen_string_literal: true

module GlipperHelper
  def display_link_to(resource, *args)
    link_to(glip(resource).display_name, [resource], *args)
  end

  def display_name(resource, options = {})
    glip(resource).display_name(options)
  end
  alias echo display_name

  def display_type(resource)
    glip(resource).display_type
  end

  def display_avatar(resource, options = {})
    glip(resource).display_avatar(options)
  end

  def label_method
    ->(i) { display_name(i) }
  end

  def link_label_method
    ->(i) { display_link_to(i) }
  end

  def timestamp(resource, field = :created_at, format = :tstamp)
    glip(resource).timestamp(field, format, current_config)
  end
  alias tw timestamp
end
