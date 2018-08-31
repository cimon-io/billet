# frozen_string_literal: true

RSpec::Matchers.define :has_scope do |scope_name|
  match do
    described_class.respond_to?(scope_name)
  end
  failure_message { "expected that #{described_class}.#{scope_name} will be a scope" }
  failure_message_when_negated { "expected that #{described_class} should not respond to scope named '#{scope_name}'" }
end
