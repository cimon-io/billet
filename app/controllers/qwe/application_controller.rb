module Qwe  class ApplicationController < ::ApplicationController
    prepend_view_path 'app/views/qwe'

    susanin(
      root: ->(r) { [:client, r] }
    )







  end
end
