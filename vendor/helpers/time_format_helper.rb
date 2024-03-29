# frozen_string_literal: true

module TimeFormatHelper
  def formatted_time(value, fmt = :default, units = :minutes) # rubocop:disable Style/FormatStringToken
    value = value.to_i.public_send(units) / 60

    case fmt
    when :short
      format('%d:%d', *value.divmod(60))
    when :full
      format('%02d:%02d:%02d', value / 1440, value % 1440 / 60, value % 60)
    when :with_days
      format('%02d:%02d:%02d', value / 1440, value % 1440 / 60, value % 60)
    else
      format('%02d:%02d', *value.divmod(60))
    end
  end
  alias ftime formatted_time
end
