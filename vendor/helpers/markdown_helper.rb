# frozen_string_literal: true

module MarkdownHelper
  # rubocop:disable Rails/OutputSafety
  def markdown_to_html(raw_text, options = {})
    render_options = {
      filter_html: false,
      escape_html: true,
      hard_wrap: true,
      link_attributes: { rel: 'nofollow' },
      with_toc_data: true
    }.merge(options.fetch(:render_options, {}))

    extensions = {
      highlight: true,
      underline: true,
      autolink: true,
      fenced_code_blocks: true,
      tables: true,
      lax_spacing: true,
      no_intra_emphasis: true,
      strikethrough: true,
      superscript: true
    }.merge(options.fetch(:extensions, {}))

    renderer = Redcarpet::Render::HTML.new(render_options)
    processor = CustomMarkdown.new(renderer, extensions)
    raw processor.render(raw_text, (self.class.method_defined?(:markdown_plugins) ? markdown_plugins(raw_text, options) : []))
  end
  # rubocop:enable Rails/OutputSafety

  def md(f, s = {}, opts = {})
    if f.is_a?(ApplicationRecord)
      markdown_to_html f.public_send(s).to_s, opts.reverse_merge(resource: f, key: f.class.name.underscore, key_field: s)
    else
      markdown_to_html(f, s)
    end
  end

  def markdown_to_html_if(enabled, resource, field, options = {})
    md(resource, field, options.merge(base_path: (enabled ? options[:base_path] : nil)))
  end
  alias md_if markdown_to_html_if
end
