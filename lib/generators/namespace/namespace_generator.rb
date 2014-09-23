class NamespaceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  class_option :access, type: 'string', default: 'cancan', desc: 'Make namespace with public access [fake, cancan none]'
  class_option :begin_chain, type: 'string', default: 'current_company', desc: 'Make namespace with public access. \'false\' if no chain begginning.'

  def initialize(*args, &block)
    super

    @access = case options.access
      when 'cancan', 'can' then 'cancan'
      when 'http' then 'http'
      when 'fakecancan', 'fake' then 'fake'
      when 'none', 'false', 'all' then 'none'
      else 'none'
    end.inquiry

    @begin_chain = options.begin_chain == 'false' ? nil : options.begin_chain
  end

  def controllers
    template 'controllers/controller.rb.erb', "app/controllers/#{instance_name}_controller.rb"
    template 'controllers/application_controller.rb.erb', "app/controllers/#{instance_name}/application_controller.rb"
    template 'controllers/home_controller.rb.erb', "app/controllers/#{instance_name}/home_controller.rb"
  end

  def views
    template 'views/home/index.html.haml.erb', "app/views/#{instance_name}/home/index.html.haml"
  end

  def routes
    template 'routes/routes.rb.erb', "config/routes/#{instance_name}_routes.rb"
    route read_template('routes/main_routes.rb.erb')
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

  def read_template(relative_path)
    ERB.new(File.read(find_in_source_paths(relative_path)), nil, '-').result(binding)
  end

end
