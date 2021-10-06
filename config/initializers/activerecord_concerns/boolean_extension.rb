module BooleanExtension
  def true?(value)
    ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES.include? value
  end

  def false?(value)
    !true?(value)
  end
end

ActiveRecord::Base.include(BooleanExtension)
