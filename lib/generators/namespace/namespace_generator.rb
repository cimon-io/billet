class NamespaceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  class_option :route, type: 'string', default: nil, desc: 'Make namespace with public access [default module_name]'
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
    @route = options.route == nil ? singular_name : options.route
  end

  def append_gem_dependency
    gem singular_name, require: singular_name, path: "./apps/#{singular_name}"
  end

  def append_routes
    route "mount #{class_name}::Engine => '/#{@route}', as: '#{singular_name}'"
  end

  def generate_apps_folder
    empty_directory "apps"
  end

  def generate_app
    template 'gemspec.erb', app_folder("#{singular_name}.gemspec")
    template 'Gemfile.erb', app_folder("Gemfile")
    template 'lib/engine.rb.erb', app_folder(:lib, singular_name, "engine.rb")
    template 'lib/version.rb.erb', app_folder(:lib, singular_name, "version.rb")
    template 'lib/module.rb.erb', app_folder(:lib, "#{singular_name}.rb")
  end

  def generate_i18n
    template 'config/locales/module_name.yml.erb', app_folder(:config, :locales, :en, "#{singular_name}.yml")
    template 'config/locales/views.yml.erb', app_folder(:config, :locales, :en, "views.yml")
    template 'config/locales/defaults.yml.erb', app_folder(:config, :locales, :en, "defaults.yml")
    template 'config/locales/activerecord.yml.erb', app_folder(:config, :locales, :en, "activerecord.yml")
  end

  def generate_controllers
    template 'controllers/controller.rb.erb', app_folder(:app, :controllers, "#{instance_name}_controller.rb")
    template 'controllers/application_controller.rb.erb', app_folder(:app, :controllers, instance_name, "application_controller.rb")
    template 'controllers/home_controller.rb.erb', app_folder(:app, :controllers, instance_name, "home_controller.rb")
    template 'controllers/concerns/.keep', app_folder(:app, :controllers, :concerns, ".keep")
  end

  def generate_views
    directory 'views/application', app_folder(:app, :views, instance_name, :application)
    template 'views/home/index.html.haml.erb', app_folder(:app, :views, instance_name, :home, "index.html.haml")
  end

  def generate_routes
    template 'config/routes.rb.erb', app_folder(:config, :routes, "routes.rb")
  end

  def generate_drappers
    template 'drappers/user_drapper.rb.erb', app_folder(:app, :drappers, instance_name, "user_drapper.rb")
    template 'drappers/application_drapper.rb.erb', app_folder(:app, :drappers, instance_name, "application_drapper.rb")

    template 'drappers/concerns/display_name_glipper.rb.erb', app_folder(:app, :drappers, :concerns, instance_name, "display_name_glipper.rb")
    template 'drappers/concerns/image_glipper.rb.erb', app_folder(:app, :drappers, :concerns, instance_name, "image_glipper.rb")
    template 'drappers/concerns/money_glipper.rb.erb', app_folder(:app, :drappers, :concerns, instance_name, "money_glipper.rb")
    template 'drappers/concerns/timestamp_glipper.rb.erb', app_folder(:app, :drappers, :concerns, instance_name, "timestamp_glipper.rb")
    template 'drappers/concerns/type_glipper.rb.erb', app_folder(:app, :drappers, :concerns, instance_name, "type_glipper.rb")
  end

  private

  def app_folder(*agrs)
    "apps/#{singular_name}/#{agrs.join(?/)}"
  end

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
