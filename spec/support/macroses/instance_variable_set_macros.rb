# frozen_string_literal: true

RSpec.configure do
  shared_examples_for 'sets instance variable' do |name, value = nil|
    it "sets instance variable @#{name}" do
      value ||= public_send(name)
      expect(subject.instance_variable_get("@#{name}")).to eq(value)
    end
  end
end
