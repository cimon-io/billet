module IconHelper

  ICON_PATH = Rails.root.join('app', 'assets', 'fonts', 'icons')
  ICON_EXTENTION = '.svg'
  ICON_NAMES = Dir[ICON_PATH.join("*#{ICON_EXTENTION}")].map {|i| File.basename(i, ICON_EXTENTION) }
  ICON_SYNONIMS = {
    add: 'plus',
    check: 'yes'
  }.with_indifferent_access
  ICON_SYNONIMS.default_proc = ->(_, i) { i }


  def icon_key(n)
    case n
    when Symbol, String
      n.downcase
    when Class
      n.name.to_s.downcase
    when Object
      n.class.name.to_s.downcase
    end
  end

  def icon_name(key)
    name = ICON_NAMES[ICON_SYNONIMS[icon_key(key)]]
    logger.warn "No icon '#{key}' in `#{ICON_PATH}`" if name.nil?
    name || key
  end

  def icon_tag(name, additional_classes="")
    content_tag :i, '', class: "icon icon-#{icon_name(name)} #{additional_classes}"
  end

end
