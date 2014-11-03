require 'rails_helper'

describe 'grabs' do

  context 'lib' do
    before(:each) do
      A1 = Class.new do
        include ActiveModel::Validations
        include ActiveRecord::Callbacks
        attr_accessor :parent_id

        def parent_id_holder
          OpenStruct.new id: 12388, parent_id: 34522
        end

        extend Grabs
        grabs :parent_id, from: :parent_id_holder
      end
      A2 = Class.new do
        include ActiveModel::Validations
        include ActiveRecord::Callbacks
        attr_accessor :grandfather_id

        def parent_id_holder
          OpenStruct.new id: 12388, parent_id: 34522
        end

        extend Grabs
        grabs :parent_id, from: :parent_id_holder, as: :grandfather_id
      end
      A3 = Class.new do
        include ActiveModel::Validations
        include ActiveRecord::Callbacks
        attr_accessor :parent_id

        def parent_id_holder
          nil
        end

        extend Grabs
        grabs :parent_id, from: :parent_id_holder
      end
    end

    after(:each) do
      Object.send(:remove_const, 'A1')
      Object.send(:remove_const, 'A2')
      Object.send(:remove_const, 'A3')
    end

    context "wth empty parent" do
      subject { A3.new }
      before(:each) do
        subject.valid?
      end

      it "should set correct parent_id" do
        expect(subject.parent_id).to be(nil)
      end
    end

    context "default behaviour" do
      subject { A1.new }
      before(:each) do
        subject.valid?
      end

      it "should set correct parent_id" do
        expect(subject.parent_id).to be(34522)
      end
    end

    context ":from" do
      subject { A2.new }
      before(:each) do
        subject.valid?
      end

      it "should set correct parent_id" do
        expect(subject.grandfather_id).to be(34522)
      end
    end
  end

  # example
  #
  # context "using in the project" do
  #   let!(:company) { create :company }
  #   let!(:network) { create :network, company: company }
  #   let!(:article) { create :article, network: network }
  #   let!(:backlink) { create :backlink, article: article }
  #   let!(:campaign) { create :campaign, company: company }
  #   let!(:page) { create :page, campaign: campaign }
  #
  #   context Backlink do
  #     subject { backlink }
  #     it(:company_id) { company.id }
  #   end
  #
  #   context Article do
  #     subject { article }
  #     it(:company_id) { company.id }
  #   end
  #
  #   context Page do
  #     subject { page }
  #     it(:company_id) { company.id }
  #   end
  #
  # end

end
