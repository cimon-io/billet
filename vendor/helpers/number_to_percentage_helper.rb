# frozen_string_literal: true

module NumberToPercentageHelper
  def custom_number_to_percentage(number, config = current_config)
    content_tag :span, class: 'percentage' do
      number_to_percentage number, precision: 1, format: config[:percentage_format]
    end
  end
  alias ntp custom_number_to_percentage
end
