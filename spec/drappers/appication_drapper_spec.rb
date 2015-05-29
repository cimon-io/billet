require 'spec_helper'

describe ApplicationDrapper do

  subject { ApplicationDrapper.decorate(create(:company)) }

  it { is_expected.to respond_to(:display_name) }
  it { is_expected.to respond_to(:display_type) }
  it { is_expected.to respond_to(:display_state) }
  it { is_expected.to respond_to(:timestamp) }

  context "instances" do
    let(:expect_glip) { ->(i) { expect(glip(create(i))) } }

    it { expect_glip[:user].to be_an_instance_of(UserDrapper) }

    it { expect{glip(nil)}.to raise_error }
    it { expect{glip(1)}.to raise_error }
  end

end
