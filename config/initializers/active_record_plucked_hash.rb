module ActiveRecordPluckedHash
  extend ActiveSupport::Concern

  def pluck_as_hash(*args)
    pluck(*args).map{|r| Hash[args.zip(r)] }
  end
end

ActiveRecord::Relation.send(:include, ActiveRecordPluckedHash)
