class ApplicationMailer < ActionMailer::Base
  layout "application"
  default :template_path => Proc.new { self.class.name.gsub(/Mailer$/, "").underscore }
  prepend_view_path ['app/views/mailers']

  # TODO: I belive that helpers should work from the box
  helper :application, :display_name

  protected

  def echo(resource)
    ApplicationDrapper.decorate(resource).blank_display_name
  end


end
