# frozen_string_literal: true

module ActiveRecordNone
  extend ActiveSupport::Concern

  included do
    def none?
      !any?
    end
  end
end

ActiveRecord::Relation.send(:include, ActiveRecordNone)
