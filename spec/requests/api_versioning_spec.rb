require "spec_helper"

shared_examples "versioning" do
  before do
    expect_any_instance_of(controller).to receive(action).and_call_original
  end
  it { send(method, url, { format: :json }, params.merge('HTTP_HOST' => host_with_subdomain("api"))) }
end

describe "general versioning" do

  context "ping V1" do
    let(:url) { '/v1/ping' }
    let(:params) { {} }
    let(:method) { :get }
    let(:controller) { Api::V1::PingController }
    let(:action) { :index }

    it_behaves_like "versioning"
  end

end
