require 'spec_helper'

describe '#mute_action' do
  before(:each) do
    A = Class.new do
      class << self
        def before_filter(*args, &block)
          # stub method
        end
      end

      extend InheritedResourcesExtentions::ClassMethods
      mute_action :index, to: :qwe
      mute_action :index1, to: "wer"
      mute_action :index2, to: -> { "ert" }, with: :collection2
      mute_action :index3, to: -> { qwe }, url_with: :collection3_url, path_with: :collection3_path

      protected

      def qwe
        25456
      end

    end
  end

  after(:each) do
    Object.send(:remove_const, 'A')
  end

  subject { A.new }

  xit { expect(subject.collection_url).to eq(25456) }
  xit { expect(subject.collection_path).to eq(25456) }
  xit { expect(subject.resource_url).to eq("wer") }
  xit { expect(subject.resource_path).to eq("wer") }
  xit { expect(subject.collection2_url).to eq("ert") }
  xit { expect(subject.collection2_path).to eq("ert") }
  xit { expect(subject.collection3_url).to eq(25456) }
  xit { expect(subject.collection3_path).to eq(25456) }

end
