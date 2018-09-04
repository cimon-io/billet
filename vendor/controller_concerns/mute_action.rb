module MuteAction
  extend ActiveSupport::Concern

  module ClassMethods
    def mute_action(action_name, options = {})
      to = options.delete(:to) { raise ":to key expected" }
      content_proc = case to
                     when String then proc { to }
                     when Symbol then proc { send(to) }
                     when Proc then to
                     else raise ":to key has undefined format"
                     end

      with = options.delete(:with) { action_name.to_sym == :index ? :collection : :resource }

      url_with = options.delete(:url_with) { "#{with}_url" }
      path_with = options.delete(:path_with) { "#{with}_path" }

      before_filter only: action_name do
        redirect_to instance_exec(&content_proc)
      end

      define_method url_with do
        instance_exec(&content_proc)
      end
      define_method path_with do
        instance_exec(&content_proc)
      end
    end
  end
end
