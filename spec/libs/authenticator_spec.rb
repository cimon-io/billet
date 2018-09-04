require 'rails_helper'

RSpec.describe Authenticator, type: :middleware do
  describe Authenticator::Middleware do
    let(:middleware) { Authenticator::Middleware.new(middleware_app) }
    before { expect_any_instance_of(Authenticator::Streak).to receive(:call).once }

    xit { expect { middleware.call(mock_request) }.to_not raise_error }
  end

  describe Authenticator::Streak
end
