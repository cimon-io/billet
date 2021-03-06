# frozen_string_literal: true

module TitleHelper
  def page_title_tag(custom_inline_title = nil)
    content_tag :title, page_title(custom_inline_title)
  end

  def page_title(custom_inline_title = nil)
    [custom_inline_title || custom_title, page_gereral_title].select(&:present?).join(" - ")
  end

  def page_gereral_title
    [title_prefix, site_title].select(&:present?).join(" - ")
  end

  def title_prefix
    nil
  end

  def site_title
    Settings.application.name
  end

  def custom_title
    content_for(:title).presence || custom_page_title
  end
end
