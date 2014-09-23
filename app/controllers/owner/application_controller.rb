module Owner

  class ApplicationController < ::ApplicationController
    prepend_view_path 'app/views/owner'

    helper_method :can?

    http_basic_authenticate_with name: Settings.admin.name, password: Settings.admin.password

    susanin(
      :root => ->(r) { [:owner, r] },
      Company => ->(r) { [:owner, r] },
      User => ->(r) { [r.company, r] },
      :companies => ->(r) { [:owner, r] }
    )

    protected

    def current_ability
      raise "What are you doing"
    end

    def title_prefix
      "Admin panel"
    end

    def can?(*args)
      true
    end

  end

end
