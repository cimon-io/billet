Rails.application.config.generators do |g|
  g.template_engine :haml
  g.helper false
  g.assets false
  g.factory_bot false
  g.test_framework :rspec, fixture: false,
                           view_specs: false,
                           controller_specs: false
end
