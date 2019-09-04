# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SentenceHelper, type: :helper do
  context ".smart_sentence" do
    let(:wrapper) { ->(k) { k } }
    let(:options) { {} }
    let(:sentence) { [] }
    subject { helper.smart_sentence(sentence, options, wrapper) }

    it { is_expected.to eq "" }

    context do
      let(:sentence) { [1, 2, 3] }
      it { is_expected.to eq "1, 2, and 3" }
    end

    context do
      let(:sentence) { [1, 2, 3, 4, 5, 6, 7, 8] }
      it { is_expected.to eq "1, 2, 3, 4, and other" }
    end

    context do
      let(:sentence) { [1, 2, 3, 4, 5, 6, 7, 8] }
      let(:options) { { count: 2, two_words_connector: ' with ' } }
      it { is_expected.to eq "1 with other" }
    end

    context do
      let(:sentence) { [1, 2, 3, 4, 5, 6, 7, 8] }
      let(:options) { { count: 3, other: 'more', words_connector: '; ', last_word_connector: ' ... ' } }
      it { is_expected.to eq "1; 2 ... more" }
    end

    context("", skip: 'uniq should be before counting') do
      let(:sentence) { [1, 1, 2, 2, 3, 3, 4, 4] }
      let(:options) { { count: 3, uniq: true } }
      it { is_expected.to eq "1, 2, and other" }
    end

    context do
      before do
        without_partial_double_verification do
          allow(helper).to receive(:display_name).and_return(1, 2, 3, 4, 5, 6, 7)
        end
      end
      let(:wrapper) { nil }
      let(:sentence) { %w[a b c d e f g] }
      it { is_expected.to eq "1, 2, 3, 4, and other" }
    end

    context do
      before do
        without_partial_double_verification do
          allow(helper).to receive(:display_link_to).and_return(1, 2, 3, 4, 5, 6, 7)
        end
      end
      let(:wrapper) { nil }
      let(:options) { { links: true } }
      let(:sentence) { %w[a b c d e f g] }
      it { is_expected.to eq "1, 2, 3, 4, and other" }
    end
  end

  context ".smart_sanitize" do
    it { expect(helper.smart_sanitize("1234567890123456789012345678901234567890123456789012345678901234567890")).to eq("123456789012345678901234567890123456...678901234567890") }
    it { expect(helper.smart_sanitize("123456789012345678", 10)).to eq("12345678...678") }
    it { expect(helper.smart_sanitize("https://example.com")).to eq("example.com") }
    it { expect(helper.smart_sanitize("http://example.com:80")).to eq("example.com") }
    it { expect(helper.smart_sanitize("123456789012345678")).to eq("123456789012345678") }
    it { expect(helper.smart_sanitize("123456789012345678", 1)).to eq("1...8") }
    it { expect(helper.smart_sanitize("123456789012345678", 0)).to eq("123456789012345678") }
  end
end
