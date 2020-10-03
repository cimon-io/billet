# frozen_string_literal: true

module ActionDispatch
  module Routing
    class Mapper
      module Resources
        #:nodoc:
        class Resource
          def default_actions
            if @api_only
              [:index, :create, :show, :update, :destroy]
            else
              [:index, :create, :new, :show, :update, :destroy, :edit, :partial]
            end
          end
        end

        #:nodoc:
        class SingletonResource < Resource
          def default_actions
            if @api_only
              [:show, :create, :update, :destroy]
            else
              [:show, :create, :update, :destroy, :new, :edit, :partial]
            end
          end
        end

        protected

        # :doc:
        def set_member_mappings_for_resource
          member do
            get :partial if parent_resource.actions.include?(:partial)
            get :edit if parent_resource.actions.include?(:edit)
            get :show if parent_resource.actions.include?(:show)
            if parent_resource.actions.include?(:update)
              patch :update
              put   :update
            end
            delete :destroy if parent_resource.actions.include?(:destroy)
          end
        end
      end
    end
  end
end
