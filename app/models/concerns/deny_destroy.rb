module DenyDestroy
  extend ActiveSupport::Concern

  module ClassMethods
    #
    # deny_destroy if: :some_method
    # deny_destroy if: -> { true && false }
    #
    def deny_destroy(opts = {})
      condition = opts.delete(:if) { raise ':if key is required' }

      return deny_destroy if: -> { send(condition) } if condition.is_a?(Symbol)

      before_destroy do
        if instance_exec(&condition)
          errors.add :base, :destroy
          false
        else
          true
        end
      end
    end
  end
end
