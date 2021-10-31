# frozen_string_literal: true

module ActiveRecordOverlaps
  extend ActiveSupport::Concern

  # Allow to check overlap with array as column. It automatically wraps
  # data with array, so second argument can be flat value if it's single
  #
  #    scope :some_scope, -> { overlapped(:field_name, [:array, :of, :data]) }
  #
  # It allows to concatenate a few scopes
  #
  #    scope :complicated_scope, -> { active.where(blah: 1).overlapped(:field_name, [:array, :of, :data]) }
  #
  # or even check several overlaps
  #
  #    scope :several_overlaps, ->(v) { overlapped(:field_name, v).or(overlapped(:another_field_name, v)) }
  #
  # or even with joined table
  #
  #    scope :several_overlaps, ->(v) { joins(:another_model).merge(AnotherModel.overlapped(:field_name, v)) }
  #
  def overlapped(field, value)
    where("ARRAY[?] && #{quoted_table_name}.#{connection.quote_column_name(field)}", Array.wrap(value))
  end
end

ActiveRecord::Base.extend(ActiveRecordOverlaps)
