# frozen_string_literal: true

RSpec.configure do
  shared_examples_for 'default set of scopes' do
    it { is_expected.to has_scope(:with_default_scope) }
    it { is_expected.to has_scope(:active) }
  end
end
