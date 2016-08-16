module CustomNormalizers
  class IntegerNormalizer
    def self.normalize(value, options = {})
      Array.wrap(value).first.to_s.to_i
    end
  end
end
