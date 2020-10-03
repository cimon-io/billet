# frozen_string_literal: true

# supported_version: Rails::VERSION::STRING '~> 6.0.3'

module ActiveRecordSample
  extend ActiveSupport::Concern

  module ClassMethods
    # rubocop:disable Style/Sample
    def sample
      shuffle.first
    end
    # rubocop:enable Style/Sample

    def shuffle
      reorder(Arel.sql("RANDOM()"))
    end
  end
end

ActiveRecord::Base.include(ActiveRecordSample)
