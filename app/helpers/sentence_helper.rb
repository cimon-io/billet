module SentenceHelper

  def smart_sentence(relation, wrapper=->(k) { display_name(k) })
    sencente_count, other_word = relation.count > 6 ? [4, "other"] : [6, nil]
    relation_links = relation.limit(sencente_count).map{ |k|
      wrapper[k]
    }
    [*relation_links, other_word].compact.to_sentence.html_safe
  end

end
