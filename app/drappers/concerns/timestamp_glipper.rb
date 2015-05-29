module TimestampGlipper

  def timestamp(field=:created_at, config=Veil.config)
    content_tag :span, get_date(field),
      data: { :toggle => "tooltip", :placement => "bottom", :timestamp => get_date(field), 'timestamp-format' => timestamp_format },
      class: 'timestamp',
      title: get_date(field)
  end

  # possible values: fromNow, default
  def timestamp_format
    :default
  end

  private def get_date(field)
    o.public_send(field).try(:iso8601) || '-'
  end

end
