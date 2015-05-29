module CustomNormalizers
  class DateStrNormalizer
    def self.normalize(value, options = {})
      result = value
      if result.is_a?(String) && result.present?
        result = DateTime.iso8601(result)
      end
      result
    end
  end
end
