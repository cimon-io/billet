require 'rails_helper'

describe Company do
  subject { create :company }

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to have_many(:projects) }
    it { is_expected.to have_many(:company_users) }
  end
end
