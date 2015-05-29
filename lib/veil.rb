class Veil

  module Controller
    def self.included(base)
      base.class_eval {
        before_filter do |c|
          Veil.set c.send(:veil_data)
        end
      }
    end

    def veil_data
      {
        :user => current_user,
        :user_id => current_user.try(:id),
        :request_id => request.uuid,
        :config => current_config,
        :company => current_company
      }
    end
  end

  class << self

    def method_missing(name, *args, &block)
      if get.key?(name.to_sym)
        get[name.to_sym]
      else
        super
      end
    end

    def default_veil_data
      {
        :user => nil,
        :user_id => nil,
        :company_user => nil,
        :company_user_id => nil,
        :request_id => nil,
        :company => nil,
        :company_id => nil,
        :config => nil
      }.with_indifferent_access
    end

    def get
      Thread.current[:veil_data] ||= default_veil_data
    end

    def set(data)
      (Thread.current[:veil_data] ||= default_veil_data).merge!(data)
    end

    def swap_data(data)
      Thread.current[:old_data] = self.get
      self.set data
    end

    def revert
      self.set Thread.current[:old_data]
    end

  end

end
