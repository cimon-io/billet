# frozen_string_literal: true

RSpec::Matchers.define :validate_url_of do |field|
  match do
    {
      'http://google.com/url' => true,
      'http://yalnsfs.cins/url/asfas/sdgs.html' => true,
      'https://sdf.sfgs/sdgs.html' => true,
      'sdf.sfgs/sdgs' => false,
      'sdf' => false,
      'asfgsdf' => false
    }.map do |url, res|
      actual.public_send("#{field}=", url)
      actual.valid?
      actual.errors[field.to_sym].include?('is not url') == res
    end.all?
  end

  failure_message { |actual| "expected that #{actual}.#{field} should be validated as url" }
  failure_message_when_negated { |actual| "expected that #{actual}.#{field} should not be validated as url" }
end
