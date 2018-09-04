# frozen_string_literal: true

module DatalinkHelper
  def datalink_if(condition, url)
    condition ? datalink(url) : {}
  end

  def datalink(url)
    { link: url }
  end
end
