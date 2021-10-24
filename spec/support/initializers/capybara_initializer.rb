require 'selenium/webdriver'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu] }
  )

  Capybara::Selenium::Driver.new app,
                                 browser: :chrome,
                                 desired_capabilities: capabilities
end

Capybara.javascript_driver = :headless_chrome

DEFAULT_HOST = ENV.fetch('DEFAULT_HOST', 'lvh.me').freeze
DEFAULT_PORT = ENV.fetch('DEFAULT_PORT', '9887').to_i.freeze

RSpec.configure do |_config|
  Capybara.default_host = "http://#{DEFAULT_HOST}"
  Capybara.server_port = DEFAULT_PORT
  Capybara.app_host = "http://#{DEFAULT_HOST}:#{Capybara.server_port}"

  def switch_to_subdomain(subdomain)
    Capybara.app_host = if subdomain.blank? || subdomain == :none
                          "http://#{DEFAULT_HOST}:#{DEFAULT_PORT}"
                        else
                          "http://#{subdomain}.#{DEFAULT_HOST}:#{DEFAULT_PORT}"
                        end
  end
end
