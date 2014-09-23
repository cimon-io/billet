class NamespaceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :scaffold_name, :type => :string, required: true, banner: 'Name of namespace'

  class_option :basic_http_auth, type: 'boolean', default: false, desc: 'Add basic http authentification'
  class_option :access, type: 'string', default: 'cancan', desc: 'Make namespace with public access'
  class_option :begin_chain, type: 'string', default: 'current_company', desc: 'Make namespace with public access'

  def initialize(*args, &block)
    super
    @basic_http_auth = options.basic_http_auth?

    case options.access
      when 'cancan', 'can'
        @cancan = true
        @public_access = false
        @access = 'cancan'
      when 'fakecancan', 'fake'
        @cancan = true
        @public_access = false
        @access = 'fake'
      when 'none', 'false'
        @cancan = false
        @public_access = true
        @access = 'none'
      else
        @cancan = false
        @public_access = true
        @access = 'none'
    end

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
