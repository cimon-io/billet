module IconHelper

  ICON_NAMES = {
    :dashboard => "dashboard",
    :yes => "yes",
    :no => "no",
    :settings => "settings",
    :campaign => "campaign",
    :company => "company",
    :external => "external",
    :cancel => "cancel",
    :search => "search",
    :user => "user",
    :logout => "logout",
    :back => "back",
    :refresh => "refresh",
    :add => "add",
    :save => "save",
    :edit => "edit",
    :password => "password",
    :updated => "updated",
    :created => "created",
    :deleted => "deleted",
    :comment => "comment"
  }.with_indifferent_access


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

  def icon_name(name)
    ICON_NAMES[icon_key(name)]
  end

  def icon_tag(name, additional_classes="")
    content_tag :i, '', class: "icon icon-#{icon_name(name)} #{additional_classes}"
  end

end
