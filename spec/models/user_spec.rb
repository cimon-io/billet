require 'rails_helper'

describe User do
  describe "validations" do
    it { is_expected.to have_many(:company_users) }
  end
end
