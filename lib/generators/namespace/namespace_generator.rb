class NamespaceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  class_option :basic_http_auth, type: 'boolean', default: false, desc: 'Add basic http authentification'
  class_option :access, type: 'string', default: 'cancan', desc: 'Make namespace with public access [fake, cancan none]'
  class_option :begin_chain, type: 'string', default: 'current_company', desc: 'Make namespace with public access'

  def initialize(*args, &block)
    super
    @basic_http_auth = options.basic_http_auth?

    @access = case options.access
      when 'cancan', 'can' then 'cancan'
      when 'http' then 'http'
      when 'fakecancan', 'fake' then 'fake'
      when 'none', 'false' then 'none'
      else 'none'
    end.inquiry

    @begin_chain = options.begin_chain == 'false' ? nil : options.begin_chain
  end

  def controllers
  end

  def views
  end

  def routes
  end

  def i18n
  end

  private

  def scaffold_name
    name
  end

  # model_name
  def singular_name
    scaffold_name.underscore
  end

  # model_names
  def plural_name
    scaffold_name.underscore.pluralize
  end

  # ModelName
  def class_name
    scaffold_name.camelize
  end

  # model_name
  def model_path
    class_name.underscore
  end

  # ModelNames
  def plural_class_name
    plural_name.camelize
  end

  # model_name
  def instance_name
    singular_name.split('/').last
  end

  # model_names
  def instances_name
    instance_name.pluralize
  end

end
