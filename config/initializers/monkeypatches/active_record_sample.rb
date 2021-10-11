# frozen_string_literal: true

# supported_version: Rails::VERSION::STRING '~> 7.0.0.alpha2'

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
