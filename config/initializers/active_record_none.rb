module ActiveRecordNone
  extend ActiveSupport::Concern

  included do
    alias_method :none?, :empty?
  end
end

ActiveRecord::Relation.send(:include, ActiveRecordNone)
