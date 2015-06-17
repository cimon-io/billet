module TimestampHelper

  def timestamp(resource, field = :created_at)
    glip(resource).timestamp(field, config=current_config)
  end
  alias_method :tw, :timestamp

  def timezone_format_to_js(source_format)
    ActiveSupport::TimeZone::MAPPING[source_format]
  end

  def date_format_to_js(source_format)
    {
      '%m/%d/%Y' => 'MM/DD/YYYY',
      '%d/%m/%Y' => 'DD/MM/YYYY',
      '%d.%m.%Y' => 'DD.MM.YYYY',
      '%y-%m-%d' => 'YY-MM-DD'
    }[source_format] || date_format_to_js(::Settings.default_user_config.date_format)
  end

  def datetime_format_to_js(source_format)
    {
      '%m/%d/%Y %H:%M' => 'MM/DD/YYYY HH:mm',
      '%d/%m/%Y %H:%M' => 'DD/MM/YYYY HH:mm',
      '%d.%m.%Y %H:%M' => 'DD.MM.YYYY HH:mm',
      '%y-%m-%d %H:%M' => 'YY-MM-DD HH:mm',
      '%m/%d/%Y %I:%M %p' => 'MM/DD/YYYY hh:mm A',
      '%d/%m/%Y %I:%M %p' => 'DD/MM/YYYY hh:mm A',
      '%d.%m.%Y %I:%M %p' => 'DD.MM.YYYY hh:mm A',
      '%y-%m-%d %I:%M %p' => 'YY-MM-DD hh:mm A'
    }[source_format] || datetime_format_to_js(::Settings.default_user_config.date_time_format)
  end

end
