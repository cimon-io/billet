module ActiveRecordSample
  extend ActiveSupport::Concern

  module ClassMethods
    def sample
      reorder("random()").first
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecordSample)
