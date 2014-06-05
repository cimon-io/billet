module DatalinkHelper

  def datalink_if(condition, url)
    condition ? { link: url } : {}
  end

end
