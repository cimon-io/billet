module CustomNormalizers
  class UrlNormalizer
    def self.normalize(value, _options = {})
      result = value
      if result.present?
        result = PostRank::URI.normalize(result).to_s
        result = PostRank::URI.extract(result)[0].to_s
        result = PostRank::URI.clean(result).to_s
      end
      result
    end
  end
end
