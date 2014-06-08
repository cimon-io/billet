require 'spec_helper'

describe User do

  describe "validations" do
    it { should belong_to :company }
  end

  describe "password_confirmation" do
    let(:params) { { email: 'example@example.com' } }
    let(:user) { User.new(params) }

    subject { user }

    before do
      subject.save
    end

    context "empty password" do
      it "should be invalid" do
        expect(subject.errors.messages[:password]).to include("can't be blank")
      end
    end

    context "without confirmation" do
      let(:params) { { email: 'example@example.com', password: 'password' } }
      it "should be invalid" do
        expect(subject.errors.messages[:password_confirmation]).to include("can't be blank")
      end
    end

    context "happy path" do
      let(:params) { { email: 'example@example.com', password: 'password', password_confirmation: 'password' } }
      it "should be invalid" do
        expect(subject.errors.messages[:password]).to be_nil
        expect(subject.errors.messages[:password_confirmation]).to be_nil
      end
    end

  end

end
