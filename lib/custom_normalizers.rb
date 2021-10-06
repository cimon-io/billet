Dir[Rails.root.join('lib', 'custom_normalizers', '**', '*.rb')].each { |f| require f }

module CustomNormalizers
end
