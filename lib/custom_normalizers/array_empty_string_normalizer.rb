module CustomNormalizers
  class ArrayEmptyStringNormalizer
    def self.normalize(value, _options = {})
      Array.wrap(value).reject(&:blank?)
    end
  end
end
