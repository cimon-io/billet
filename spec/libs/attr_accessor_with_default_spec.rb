require 'rails_helper'

describe '#attr_accessor_with_default' do
  describe AttrAccessorWithDefault do
    before(:each) do
      stub_const('A', Class.new do
        include AttrAccessorWithDefault

        attr_accessor_with_default :qwe1
        attr_accessor_with_default :qwe2 do
          100
        end
        attr_accessor_with_default :qwe3 do
          qwe2 * qwe1
        end
      end)
    end

    let(:a) { A.new }

    before do
      a.qwe1 = 2
    end

    it { expect(a.qwe1).to eq(2) }
    it { expect(a.qwe2).to eq(100) }
    it { expect(a.qwe3).to eq(200) }
  end
end
