module PageTitle
  extend ActiveSupport::Concern

  included do
    helper_method :custom_page_title
    hide_action :custom_page_title
  end

  module ClassMethods
    def page_title(content = "")
      content_proc = if block_given?
                       Proc.new
                     else
                       Proc.new { content }
                     end
      define_method :custom_page_title do
        @custom_page_title ||= instance_exec(&content_proc)
      end
    end
  end

  def custom_page_title
  end

  def set_page_title
  end

end
