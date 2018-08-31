require 'rails_helper'

describe BaseUploader do
  include CarrierWave::Test::Matchers

  before do
    BaseUploader.enable_processing = true
  end

  after do
    BaseUploader.enable_processing = false
  end

  context "check format" do
    subject { BaseUploader.new OpenStruct.new(id: 1) }
    let(:uploader) { subject.store!(get_file(filename)) }

    context 'png' do
      let(:filename) { 'wave.png' }
      it { expect { uploader }.not_to raise_error }
    end

    context 'jpeg' do
      let(:filename) { 'wat.jpeg' }
      it { expect { uploader }.not_to raise_error }
    end

    context 'jpg' do
      let(:filename) { 'ruby.jpg' }
      it { expect { uploader }.not_to raise_error }
    end

    context 'gif' do
      let(:filename) { 'yoda.gif' }
      it { expect { uploader }.not_to raise_error }
    end

    context 'doc' do
      let(:filename) { 'any.docx' }
      it { expect { uploader }.not_to raise_error }
    end
  end
end
