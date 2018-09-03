# frozen_string_literal: true

module ActiveRecordSample
  extend ActiveSupport::Concern

  module ClassMethods
    # rubocop:disable Performance/Sample
    def sample
      shuffle.first
    end
    # rubocop:enable Performance/Sample

    def shuffle
      reorder(Arel.sql("RANDOM()"))
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecordSample)
