require 'attribute_normalizer'

AttributeNormalizer.configure do |config|
  config.normalizers[:url_normalizer] = CustomNormalizers::UrlNormalizer
  config.normalizers[:date_str_normalizer] = CustomNormalizers::DateStrNormalizer
  config.normalizers[:array_empty_string] = CustomNormalizers::ArrayEmptyStringNormalizer
  config.normalizers[:integer] = CustomNormalizers::IntegerNormalizer
end
