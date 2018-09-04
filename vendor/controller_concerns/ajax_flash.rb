module AjaxFlash
  extend ActiveSupport::Concern

  included do
    after_filter { flash.discard if request.xhr? }
  end
end
