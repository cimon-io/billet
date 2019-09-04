# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HtmlDomHelper, type: :helper do
  let(:user) { double(User, model_name: double(:model_name, param_key: 'user'), id: 114) }
  let(:new_user) { double(User, model_name: double(:model_name, param_key: 'user'), id: nil) }
  let(:project) { double(Project, model_name: double(:model_name, param_key: 'project'), id: 654) }

  context ".dom_id" do
    it { expect(helper.dom_id(user)).to eq "user_114" }
    it { expect(helper.dom_id(project)).to eq "project_654" }
    it { expect(helper.dom_id(project, user)).to eq "project_654-user_114" }
    it { expect(helper.dom_id(Project, :list)).to eq "project-list" }
    it { expect(helper.dom_id(new_user)).to eq "user_new" }
    it { expect(helper.dom_id(new_user, double(:a, to_sym: 'qwe'))).to eq "user_new-qwe" }
    it { expect(helper.dom_id(:prefix, User, new_user, :suffix)).to eq "prefix-user-user_new-suffix" }
  end

  context ".css_id" do
    before { expect(helper).to receive(:dom_id).once.with(1, 2).and_return(3) }
    it { expect(helper.css_id(1, 2)).to eq("#3") }
  end

  context ".dom_klass"

  context ".collection_class" do
    let(:obj) { double(User, model_name: double(:model_name, plural: 'qwe')) }
    it { expect(helper.collection_class(User)).to eq('users-list') }
    it { expect(helper.collection_class(Company)).to eq('companies-list') }
    it { expect(helper.collection_class(obj)).to eq('qwe-list') }
  end
end
