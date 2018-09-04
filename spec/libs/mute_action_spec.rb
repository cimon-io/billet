require 'spec_helper'

describe '#mute_action' do
  before(:each) do
    A = Class.new do
      class << self
        def before_filter(*args, &block)
          # stub method
        end
      end

      include MuteAction

      mute_action :index, to: :qwe
      mute_action :index1, to: "wer"
      mute_action :index2, to: -> { "ert" }, with: :collection2
      mute_action :index3, to: -> { qwe }, url_with: :collection3_url, path_with: :collection3_path

      def qwe
        25_456
      end
    end
  end

  after(:each) do
    Object.send(:remove_const, 'A')
  end

  subject { A.new }

  its(:collection_url) { is_expected.to eq(25_456) }
  its(:collection_path) { is_expected.to eq(25_456) }
  its(:resource_url) { is_expected.to eq("wer") }
  its(:resource_path) { is_expected.to eq("wer") }
  its(:collection2_url) { is_expected.to eq("ert") }
  its(:collection2_path) { is_expected.to eq("ert") }
  its(:collection3_url) { is_expected.to eq(25_456) }
  its(:collection3_path) { is_expected.to eq(25_456) }
end
