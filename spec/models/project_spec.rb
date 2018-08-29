require 'rails_helper'

describe Project do
  subject { create :project }

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to belong_to(:company) }
  end
end
