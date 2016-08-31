module CustomNormalizers
  class NameNormalizer
    def self.normalize(str, options = {})
      join_string = "..."
      length = options.fetch(:length, 50) - join_string.size - 1
      str = str.to_s.strip

      return str if str.size < length

      from = (length * 0.7).to_i
      to = length - from
      [str[0..from], join_string, str[-to..-1]].join()
    end
  end
end
