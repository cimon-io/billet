module InheritedResourcesExtentions
  extend ActiveSupport::Concern

  included do
    helper_method :parent_class, :parent?
  end

  module ClassMethods
    def inherit_resources_defaults
      include InheritedResourcesDefaults
    end

    def inherit_resources_with_defaults
      self.inherit_resources
      self.inherit_resources_defaults
    end

    def mute_action(action_name, options={})
      to = options.delete(:to) { raise ":to key expected" }
      content_proc = case to
        when String then Proc.new { to }
        when Symbol then Proc.new { self.send(to) }
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

  module InheritedResourcesDefaults
    extend ActiveSupport::Concern

    included do
      authorize_resource
      authorize_resource_state_events
    end

    protected

    def begin_of_association_chain
      current_company
    end

    def end_of_association_chain
      scope = super
      if scope.respond_to? :accessible_by
        scope.accessible_by(current_ability)
      else
        scope
      end
    end

    def permitted_params_key
      resource_class.to_s.underscore
    end

    def permitted_params_value
      []
    end

    def permitted_params
      params.permit(permitted_params_key => permitted_params_value)
    end

  end

  protected

  def parent?
    false
  end

  def parent_class
    parent.class
  end

end
