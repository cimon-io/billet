class Range
  # rubocop:disable Metrics/PerceivedComplexity, Style/CaseEquality
  def intersection(other)
    raise ArgumentError, 'value must be a Range' unless other.is_a?(Range)

    my_min = first
    my_max = (exclude_end? ? max : last)
    other_min = other.first
    other_max = (other.exclude_end? ? other.max : other.last)

    new_min = if self === other_min
                other_min
              else
                other === my_min ? my_min : nil
              end

    new_max = if self === other_max
                other_max
              else
                other === my_max ? my_max : nil
              end

    new_min && new_max ? new_min..new_max : 0...0
  end
  # rubocop:enable Metrics/PerceivedComplexity, Style/CaseEquality

  def intersection_ratio(other)
    size.positive? ? (intersection(other).size.to_f / size) : 0
  end
end
