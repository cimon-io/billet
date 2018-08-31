# frozen_string_literal: true

RSpec.configure do
  shared_examples_for 'rescues error with Rollbar notification for' do |error|
    let(:rollbar) { Rollbar }
    let(:msg) { 'Hooks API server is not available' }
    let(:error_class) { error }

    it "rescues #{error} with Rollbar notification" do
      expect(rollbar).to receive(:error).with(anything, msg)
      subject
    end
  end
end
