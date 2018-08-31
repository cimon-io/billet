# frozen_string_literal: true

module Egg
  RSpec.configure do
    shared_examples_for 'for field or connection type' do |field:, type:, resolver_class: nil, hash_key: nil, property: nil, preload: nil|
      describe "##{field}" do
        let(:fields) { described_class.fields }
        let(:current_field) { fields[field] }

        context 'type' do
          subject { current_field.type }

          it { is_expected.to eq(type) }
        end

        if resolver_class
          context 'resolver' do
            subject { current_field.function }

            it { is_expected.to be_instance_of(resolver_class) }
          end
        end

        if hash_key
          context ':hash_key option' do
            subject { current_field.hash_key }

            it { is_expected.to eq(hash_key) }
          end
        end

        if property
          context ':property option' do
            subject { current_field.property }

            it { is_expected.to eq(property) }
          end
        end

        if preload
          context ':preload option' do
            subject { current_field.metadata[:preload] }

            it { is_expected.to eq(preload) }
          end
        end
      end
    end

    shared_examples_for 'for argument type' do |name:, type:, as: nil|
      describe "##{name}" do
        let(:arguments) { described_class.new.arguments }

        context 'type' do
          subject { arguments[name].type }

          it { is_expected.to eq(type) }
        end

        next unless as

        context ':as option' do
          subject { arguments[name].as }

          it { is_expected.to eq(as) }
        end
      end
    end
  end
end
