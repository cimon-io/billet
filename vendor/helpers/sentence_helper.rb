# frozen_string_literal: true

module SentenceHelper
  # rubocop:disable Rails/OutputSafety
  def smart_sentence(relation, options = {}, wrapper = nil)
    if options.is_a?(Proc)
      wrapper = options
      options = {}
    end

    count = options.delete(:count) { 6 }
    is_uniq = options.delete(:uniq)
    is_links = options.delete(:links)
    other_word = options.delete(:other) || "other"

    sentence_options = Hash[[
      [:words_connector, options.delete(:words_connector)],
      [:two_words_connector, options.delete(:two_words_connector)],
      [:last_word_connector, options.delete(:last_word_connector)],
      [:locale, options.delete(:locale)]
    ].reject { |i| i.second.nil? }]

    wrapper ||= (is_links ? ->(k) { display_link_to(k) } : ->(k) { display_name(k) })

    relation_links, other_word = smart_sentence_relation_links(relation, count, other_word, wrapper)
    [*(is_uniq ? relation_links.uniq : relation_links), other_word].compact.to_sentence(sentence_options).html_safe
  end
  # rubocop:enable Rails/OutputSafety

  def smart_sentence_relation_links(relation, count = 6, other_word = "other", wrapper = ->(k) { display_name(k) })
    sentence_count, other_word = relation.size > count ? [(count * 0.8).to_i, other_word] : [count, nil]
    relation_links = relation.take(sentence_count).map { |k| wrapper[k] }

    [relation_links, other_word]
  end

  def smart_sanitize(str, length = 50)
    str = str.to_s
    from = (length * 0.7).to_i
    to = length - from

    if str.scan(%r{^(http(s)?\:\/\/)}).any?
      str = str.gsub(/\:80\z/, '')
      str = str.gsub(%r{\Ahttp(s)?\:\/\/}, '')
    end

    return str unless should_sanitized?(str, length)
    [str[0..from], '...', str[-to..-1]].join
  end

  def should_sanitized?(str, length = 50)
    length.positive? && str.size > length
  end
end
