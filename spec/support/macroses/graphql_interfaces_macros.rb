# frozen_string_literal: true

module Egg
  RSpec.configure do
    shared_examples_for 'for interface' do |interface|
      subject { described_class.interfaces }

      it "implements #{interface}" do
        is_expected.to include(interface)
      end
    end
  end
end
