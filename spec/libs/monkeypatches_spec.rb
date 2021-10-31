require 'rails_helper'

RSpec.describe 'config/initializers/monkeypatches', type: :lib do
  Dir.glob(Rails.root.join('config', 'initializers', 'monkeypatches', '**', '*.rb')) do |filename|
    it "#{File.basename(filename)} monkeypatch" do
      File.readlines(filename).each do |line|
        /\A# supported_version: (?<current_version_const>\S+) '(?<supported_version_expression>.+)'$/ =~ line
        next if current_version_const.nil?

        expect(current_version_const).not_to be_nil, 'has no supported_version declaration'

        current_version = current_version_const.safe_constantize
        expect(current_version).not_to be_nil, 'supported_version declaration is not a correct version'

        supported_dependency = Gem::Dependency.new('', supported_version_expression)
        expect(supported_dependency.match?('', current_version)).to be_truthy, 'is outdated. Please, update monkeypath.'
      end
    end
  end
end
