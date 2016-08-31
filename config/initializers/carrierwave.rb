# NullStorage provider for CarrierWave for use in tests.  Doesn't actually
# upload or store files but allows test to pass as if files were stored and
# the use of fixtures.
class NullStorage
  attr_reader :uploader

  def initialize(uploader)
    @uploader = uploader
  end

  def identifier
    uploader.filename
  end

  def store!(_file)
    true
  end

  def retrieve!(_identifier)
    true
  end
end

CarrierWave.configure do |config|
  config.asset_host = ENV.fetch('UPLOAD_1_HOST', "http://" + ENV.fetch('CIMON_DOMAIN_0', "lvh.me:3000"))

  if Rails.env.test?
    config.storage NullStorage
    config.enable_processing = false
  end
end
