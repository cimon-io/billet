module SentenceHelper

  def smart_sentence(relation, wrapper=->(k) { display_name(k) })
    sencente_count, other_word = relation.count > 6 ? [4, "other"] : [6, nil]
    relation_links = relation.limit(sencente_count).map{ |k|
      wrapper[k]
    }
    [*relation_links, other_word].compact.to_sentence.html_safe
  end

  def smart_sanitize(str, length=50)
    from = (length * 0.7).to_i
    to = length - from

    return str if str.size < length
    str = str.gsub /^http(s)?\:\/\//, ''
    [str[0..from], '...', str[-to..-1]].join()
  end

end
