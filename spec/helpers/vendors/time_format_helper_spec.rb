# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeFormatHelper, type: :helper do
  describe '.ftime' do
    context ':nil value' do
      subject { helper.ftime(nil) }
      it { is_expected.to eq('00:00') }
    end

    context ':default format' do
      subject { helper.ftime(65) }
      it { is_expected.to eq('01:05') }
    end

    context ':short format' do
      subject { helper.ftime(63, :short) }
      it { is_expected.to eq('1:3') }
    end

    context ':full format' do
      subject { helper.ftime(69, :full) }
      it { is_expected.to eq('00:01:09') }
    end

    context ':minutes units' do
      subject { helper.ftime(68) }
      it { is_expected.to eq('01:08') }
    end

    context ':seconds units' do
      subject { helper.ftime(3660, :default, :seconds) }
      it { is_expected.to eq('01:01') }
    end

    context ':hours units' do
      subject { helper.ftime(61, :default, :hours) }
      it { is_expected.to eq('61:00') }
    end
  end
end
