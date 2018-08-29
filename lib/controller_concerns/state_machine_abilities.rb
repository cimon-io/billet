module StateMachineAbilities
  extend ActiveSupport::Concern

  module ClassMethods
    def authorize_resource_state_events(opts = {})
      key = opts.delete(:key) { :state_event }
      filter_params = ({ only: [:update] }).merge(opts)

      before_filter(filter_params) do
        unless params[permitted_params_key][key].nil?
          authorize! permission_name(params[permitted_params_key][key]), resource
        end
      end
    end
  end

  def permission_name(key)
    key.to_sym
  end
end
