class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def custom_returning_columns(table_ref, action)
      return [] if ['"schema_migrations"', '"ar_internal_metadata"'].include?(table_ref)

      res = []
      res << :created_at if action == :create
      res << :updated_at

      # res += case table_ref
      #        when '"companies"'
      #          [:name]
      #        when '"projects"'
      #          [:name]
      #        else
      #          []
      #        end

      res
    end
  end
end
