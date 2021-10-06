require 'spec_helper'

describe '#mute_action' do
  before(:each) do
    stub_const('A', Class.new do
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
    end)
  end

  subject(:action) { A.new }

  it { expect(action.collection_url).to eq(25_456) }
  it { expect(action.collection_path).to eq(25_456) }
  it { expect(action.resource_url).to eq("wer") }
  it { expect(action.resource_path).to eq("wer") }
  it { expect(action.collection2_url).to eq("ert") }
  it { expect(action.collection2_path).to eq("ert") }
  it { expect(action.collection3_url).to eq(25_456) }
  it { expect(action.collection3_path).to eq(25_456) }
end
