class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'application'
  default template_path: proc { self.class.name.gsub(/Mailer$/, "").underscore }
  prepend_view_path ['app/views/mailers']
end
