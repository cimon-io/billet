module CustomNormalizers
  class ArrayEmptyStringNormalizer
    def self.normalize(value, options = {})
      Array.wrap(value).reject(&:blank?)
    end
  end
end
