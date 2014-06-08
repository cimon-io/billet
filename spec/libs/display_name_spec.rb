require 'spec_helper'

describe '#display_name' do
  [Company, User, Project].each do |klass|
    describe klass do
      it { is_expected.to respond_to(:display_name) }
    end
  end

  describe User do
    it { expect(User.new(email: "example@qwe.com").display_name).to eq('example') }
    it { expect(User.new.display_name).to eq('New user') }
    it { expect(User.new(id: "15").display_name).to eq('User 15') }
  end

  describe Company do
    it { expect(Company.new(name: "example").display_name).to eq('example') }
    it { expect(Company.new.display_name).to eq('New company') }
    it { expect(Company.new(id: "14").display_name).to eq('Company 14') }
  end

  describe Project do
    it { expect(Project.new(name: "Project").display_name).to eq('Project') }
    it { expect(Project.new.display_name).to eq('New project') }
    it { expect(Project.new(id: "13").display_name).to eq('Project 13') }
  end

end
