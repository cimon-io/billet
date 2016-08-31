class NamespaceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  class_option :api, type: 'string', default: false, desc: 'Make namespace as API'
  class_option :route, type: 'string', default: nil, desc: 'Make namespace with public access [default module_name]'
  class_option :access, type: 'string', default: 'cancan', desc: 'Make namespace with public access [fake, cancan none]'
  class_option :begin_chain, type: 'string', default: 'current_company', desc: 'Make namespace with public access. \'false\' if no chain begginning.'

  def initialize(*args, &block)
    super

    @api = case options.api
      when 'true', 't', '1', 'yes', 'True', 'TRUE', true then true
      else false
    end

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

  def generate_ability
    template 'abilities/ability.rb.erb', app_folder(:app, :abilities, singular_name, "ability.rb")
  end

  def generate_controllers
    template 'controllers/controller.rb.erb', app_folder(:app, :controllers, "#{instance_name}_controller.rb")
    template 'controllers/application_controller.rb.erb', app_folder(:app, :controllers, instance_name, "application_controller.rb")
    template 'controllers/home_controller.rb.erb', app_folder(:app, :controllers, instance_name, "home_controller.rb")

    template 'controller_concerns/.keep', app_folder(:app, :controllers, :concerns, ".keep")

    if @api
      template 'controller_concerns/api_current_identity.rb.erb', app_folder(:app, :controllers, :concerns, instance_name, "current_identity.rb")
    end

    if @access.cancan?
      template 'controller_concerns/current_identity.rb.erb', app_folder(:app, :controllers, :concerns, instance_name, "current_identity.rb")
    end
  end

  def generate_views
    if @api
      directory 'api_views', app_folder(:app, :views, instance_name)
    else
      directory 'views/application', app_folder(:app, :views, instance_name, :application)
      template 'views/home/index.html.haml.erb', app_folder(:app, :views, instance_name, :home, "index.html.haml")
      template 'views/layouts/application.html.haml.erb', app_folder(:app, :views, :layouts, instance_name, "application.html.haml")
    end
  end

  def generate_routes
    if @api
      template 'config/api_routes.rb.erb', app_folder(:config, "routes.rb")
    else
      template 'config/routes.rb.erb', app_folder(:config, "routes.rb")
    end
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

  def generate_helpers
    template "helpers/application_helper.rb.erb", app_folder(:app, :helpers, instance_name,"application_helper.rb")
    template "helpers/boolean_helper.rb.erb", app_folder(:app, :helpers, instance_name,"boolean_helper.rb")
    template "helpers/datalink_helper.rb.erb", app_folder(:app, :helpers, instance_name,"datalink_helper.rb")
    template "helpers/display_name_helper.rb.erb", app_folder(:app, :helpers, instance_name,"display_name_helper.rb")
    template "helpers/erb_helper.rb.erb", app_folder(:app, :helpers, instance_name,"erb_helper.rb")
    template "helpers/glipper_helper.rb.erb", app_folder(:app, :helpers, instance_name,"glipper_helper.rb")
    template "helpers/human_attribute_helper.rb.erb", app_folder(:app, :helpers, instance_name,"human_attribute_helper.rb")
    template "helpers/i18n_helper.rb.erb", app_folder(:app, :helpers, instance_name,"i18n_helper.rb")
    template "helpers/image_helper.rb.erb", app_folder(:app, :helpers, instance_name,"image_helper.rb")
    template "helpers/money_helper.rb.erb", app_folder(:app, :helpers, instance_name,"money_helper.rb")
    template "helpers/number_to_percentage_helper.rb.erb", app_folder(:app, :helpers, instance_name,"number_to_percentage_helper.rb")
    template "helpers/sentence_helper.rb.erb", app_folder(:app, :helpers, instance_name,"sentence_helper.rb")
    template "helpers/timestamp_helper.rb.erb", app_folder(:app, :helpers, instance_name,"timestamp_helper.rb")

    unless @api
      template "helpers/title_helper.rb.erb", app_folder(:app, :helpers, instance_name,"title_helper.rb")
      template "helpers/flash_helper.rb.erb", app_folder(:app, :helpers, instance_name,"flash_helper.rb")
    end
  end

  def generate_assets
    empty_directory app_folder(:app, :assets)
    empty_directory app_folder(:app, :assets, :images)
    directory 'assets/images', app_folder(:app, :assets, :images)
    unless @api
      empty_directory app_folder(:app, :assets, :javascripts)
      template "assets/javascripts/js.coffee.erb", app_folder(:app, :assets, :javascripts, "#{instance_name}.coffee")

      empty_directory app_folder(:app, :assets, :stylesheets)
      template "assets/stylesheets/css.scss.erb", app_folder(:app, :assets, :stylesheets, "#{instance_name}.scss")
    end
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
