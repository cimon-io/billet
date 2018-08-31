# frozen_string_literal: true

module Egg
  RSpec.configure do
    shared_examples_for 'for common resolvers function' do |getter:, type:, handler:|
      its(:type) { is_expected.to eq(type) }

      describe '#call' do
        let(:object) { double(:object) }
        let(:arguments) { double(:arguments) }
        let(:context) { double(:context) }

        it "calls :#{getter} on #{handler}" do
          expect(handler).to receive(getter).with(object, arguments, context)
          subject.call(object, arguments, context)
        end
      end
    end
  end
end
