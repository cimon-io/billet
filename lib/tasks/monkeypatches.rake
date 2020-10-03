# frozen_string_literal: true

namespace :monkeypatches do
  desc 'Checks if monkeypatches are up to date.'
  task outdated: [:environment] do
    Dir.glob(Rails.root.join('config', 'initializers', '**', '*.rb')) do |filename|
      File.readlines(filename).each do |line|
        /\A# supported_version: (?<current_version_const>\S+) '(?<supported_version_expression>.+)'$/ =~ line
        next if current_version_const.nil?

        supported_dependency = Gem::Dependency.new('', supported_version_expression)
        current_version = current_version_const.safe_constantize
        abort("Outdated monkeypatch at `#{filename}`") unless current_version && supported_dependency.match?('', current_version)
      end
    end

    puts('All monkeypatches are up to date.')
  end
end
