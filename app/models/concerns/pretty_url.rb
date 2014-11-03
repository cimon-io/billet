module PrettyUrl
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def pretty_url_for(method_name)
      define_method "pretty_#{method_name}" do
        self.send(method_name).gsub(/^http(s)?\:\/\/(www\.)?/, '').gsub(/\/$/, '').truncate(50)
      end
    end
  end

end
