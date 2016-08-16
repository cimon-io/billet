module CustomNormalizers
  class DateStrNormalizer
    def self.normalize(value, options = {})
      result = value
      if result.is_a?(String) && result.present?
        result = Date.strptime(result, Veil.config.date_format)
      end
      result
    end
  end
end
