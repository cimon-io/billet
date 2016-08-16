module UnobtrusiveController
  extend ActiveSupport::Concern
  # required methods
  #  :relationship_name
  #  :resource_class
  #  :find_for_create_by
  #  :permitted_params_key
  #  :permitted_params_create_value
  #  :permitted_params_update_value

  #  :parent_class
  #  :parent_permitted_params_key

  module ClassMethods

    def unobtrusive_method(method_name, &block)
      return method_name if method_defined?(method_name)
      define_method(method_name, &block)
    end

    def unobtrusive(options)
      helper_method :collection, :resource, :resource_class, :resource_collection_name, :resource_name, :collection_url, :resource_url, :new_resource_url

      options.each do |key, value|
        unobtrusive_method key, &(value.respond_to?(:call) ? value : -> { value })
      end

      unobtrusive_method :collection do
        instance_variable_set(:@_collection, end_of_association_chain) unless instance_variable_defined?(:@_collection)
        instance_variable_get(:@_collection)
      end

      unobtrusive_method :resource do
        instance_variable_set(:@_resource, end_of_association_chain.public_send(finder_method, unoptrusive_params[finder_param])) unless instance_variable_defined?(:@_resource)
        instance_variable_get(:@_resource)
      end

      unobtrusive_method :build_resource do
        instance_variable_set(:@_resource, end_of_association_chain.build)
      end

      unobtrusive_method :find_or_create_resource do
        instance_variable_set(:@_resource, end_of_association_chain.create_with(permitted_params).find_or_create_by(find_for_create_by => permitted_params[find_for_create_by]))
      end

      unobtrusive_method :update_resource do
        resource.update(permitted_params)
      end

      unobtrusive_method :destroy_resource do
        resource.destroy
      end

      unobtrusive_method :association_chain do
        begin_of_association_chain.public_send(relationship_name)
      end

      unobtrusive_method :association_chain_with_includes do
        association_chain
      end

      unobtrusive_method :end_of_association_chain do
        association_chain_with_includes
      end

      unobtrusive_method :unoptrusive_params do
        params
      end

      unobtrusive_method :finder_method do
        :find
      end

      unobtrusive_method :finder_param do
        :id
      end

      unobtrusive_method :resource_collection_name do
        resource_class.model_name.human(count: 2)
      end

      unobtrusive_method :resource_name do
        resource_class.model_name.human(count: 1)
      end

      unobtrusive_method :permitted_params do
        unoptrusive_params.permit(permitted_params_key => send("permitted_params_#{action_name}_value"))[permitted_params_key]
      end

      unobtrusive_method :collection_url do
        url_for([relationship_name])
      end

      unobtrusive_method :resource_url do
        url_for([resource])
      end

      unobtrusive_method :new_resource_url do
        url_for([:new, relationship_name])
      end

      # parent methods
      if method_defined?(:parent_class)
        helper_method :parent, :parent_class, :parent_name, :parent_collection_name, :parent_url

        unobtrusive_method :parent do
          instance_variable_set(:@_parent, parent_class.public_send(parent_finder_method, unoptrusive_params[parent_finder_param])) unless instance_variable_defined?(:@_parent)
          instance_variable_get(:@_parent)
        end

        unobtrusive_method :unoptrusive_parent_params do
          params
        end

        unobtrusive_method :parent_finder_method do
          :find
        end

        unobtrusive_method :parent_finder_param do
          :id
        end

        unobtrusive_method :parent_collection_name do
          parent_class.model_name.human(count: 2)
        end

        unobtrusive_method :parent_name do
          parent_class.model_name.human(count: 1)
        end

        unobtrusive_method :parent_url do
          url_for([parent])
        end

      end

      if method_defined?(:parent_class)
        unobtrusive_method :begin_of_association_chain do
          parent
        end
      else
        unobtrusive_method :begin_of_association_chain do
          OpenStruct.new(relationship_name => resource_class.all)
        end
      end

    end
  end

end
