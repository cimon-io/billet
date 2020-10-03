# supported_version: Rails::VERSION::STRING '~> 6.0.3'

module ActiveRecordPluckedHash
  extend ActiveSupport::Concern

  def pluck_as_hash(*args)
    pluck(*args.map { |f| f.is_a?(String) ? Arel.sql(f) : f }).map { |r| Hash[args.zip(r)] }
  end

  def pick_as_hash(*args)
    Hash[args.zip(Array.wrap(pick(*args.map { |f| f.is_a?(String) ? Arel.sql(f) : f })))]
  end
end

ActiveRecord::Relation.include(ActiveRecordPluckedHash)
