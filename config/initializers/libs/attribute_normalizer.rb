require 'attribute_normalizer'
require 'custom_normalizers'

AttributeNormalizer.configure do |config|
  config.normalizers[:url] = CustomNormalizers::UrlNormalizer
  config.normalizers[:date_str_normalizer] = CustomNormalizers::DateStrNormalizer
  config.normalizers[:array_empty_string] = CustomNormalizers::ArrayEmptyStringNormalizer
  config.normalizers[:integer] = CustomNormalizers::IntegerNormalizer
  config.normalizers[:name] = CustomNormalizers::NameNormalizer
end
