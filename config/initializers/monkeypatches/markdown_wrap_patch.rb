# frozen_string_literal: true

# https://github.com/vmg/redcarpet/issues/92#issuecomment-35462000
module RedcarpetRenderWithoutWrap
  def postprocess(full_document)
    Regexp.new(%r{\A<p>(.*)<\/p>\Z}m).match(full_document)[1]
  rescue StandardError
    full_document
  end
end

Redcarpet::Render::HTML.send(:include, RedcarpetRenderWithoutWrap)
