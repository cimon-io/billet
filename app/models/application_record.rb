class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  class << self
    def custom_returning_columns(table_ref, action)
      return [] if ['"schema_migrations"', '"ar_internal_metadata"'].include?(table_ref)

      res = []
      res << :created_at if action == :create
      res << :updated_at

      res += case table_ref
             when '"companies"'
               [:projects_count]
             #  when '"projects"'
             #    [:name]
             else
               []
             end

      res
    end
  end
end
