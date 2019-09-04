# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MarkdownHelper, type: :helper do
  describe '.markdown_to_html_if (.md_if)' do
    before do
      allow(resource).to receive(:field).and_return('Some value')
    end

    let(:resource) { double(:resource) }
    let(:options) { [resource, :field, base_path: base_path] }
    subject { helper.md_if(*params) }

    context 'with first param set to true' do
      let(:params) { [true, resource, :field, base_path: "url"] }
      let(:base_path) { "url" }

      it 'call .md with {base_path: false} in html_options' do
        expect(helper).to receive(:md).with(*options)
        subject
      end
    end

    context 'with first param set to false' do
      let(:params) { [false, resource, :field, base_path: "url"] }
      let(:base_path) { nil }

      it 'call .md with {base_path: true} in html_options' do
        expect(helper).to receive(:md).with(*options)
        subject
      end
    end
  end
end
