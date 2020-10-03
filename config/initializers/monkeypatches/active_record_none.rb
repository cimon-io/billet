# frozen_string_literal: true

# supported_version: Rails::VERSION::STRING '~> 6.0.3'

module ActiveRecordNone
  extend ActiveSupport::Concern

  included do
    def none?
      !any?
    end
  end
end

ActiveRecord::Relation.include(ActiveRecordNone)
