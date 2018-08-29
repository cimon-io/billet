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

      protected

      def qwe
        25_456
      end
    end
  end

  after(:each) do
    Object.send(:remove_const, 'A')
  end

  subject { A.new }

  it { expect(subject.collection_url).to eq(25_456) }
  it { expect(subject.collection_path).to eq(25_456) }
  it { expect(subject.resource_url).to eq("wer") }
  it { expect(subject.resource_path).to eq("wer") }
  it { expect(subject.collection2_url).to eq("ert") }
  it { expect(subject.collection2_path).to eq("ert") }
  it { expect(subject.collection3_url).to eq(25_456) }
  it { expect(subject.collection3_path).to eq(25_456) }
end
