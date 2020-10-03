# supported_version: RUBY_VERSION '~> 2.7.1'

class String
  BRA2KET = { '[' => ']', '(' => ')', '{' => '}', '<' => '>' }.freeze

  # Return a new string embraced by given brackets.
  # If only one bracket char is given it will be placed
  # on either side.
  #
  #   "wrap me".bracket('{')        #=> "{wrap me}"
  #   "wrap me".bracket('--','!')   #=> "--wrap me!"
  #
  def bracket(bra, ket = nil)
    return self if empty?

    "#{bra}#{self}#{ket || BRA2KET[bra] || bra}"
  end

  # Inplace version of #bracket.
  #
  def bracket!(bra, ket = nil)
    replace(bracket(bra, ket))
  end

  # Return a new string with the given brackets removed.
  # If only one bracket char is given it will be removed
  # from either side.
  #
  #   "{unwrap me}".unbracket('{')        #=> "unwrap me"
  #   "--unwrap me!".unbracket('--','!')  #=> "unwrap me"
  #
  def unbracket(bra = nil, ket = nil)
    if bra
      ket ||= BRA2KET[bra] || bra
      s = dup
      s.gsub!(/^#{Regexp.escape(bra)}/, '')
      s.gsub!(/#{Regexp.escape(ket)}$/, '')
      return s
    elsif (m = BRA2KET[self[0, 1]])
      return slice(1...-1) if self[-1, 1] == m
    end

    dup # if nothing else
  end

  # Inplace version of #unbracket.
  #
  def unbracket!(bra = nil, ket = nil)
    replace(unbracket(bra, ket))
  end
end
