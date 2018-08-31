class CompanyProjectsCounter < ActiveRecord::Migration[5.1]
  def change
    counter_trigger(parent_table: :companies, child_table: :projects, counter_column: :projects_count, foreign_column: :company_id)
  end

  def counter_trigger(parent_table:, child_table:, counter_column:, foreign_column:)
    function_name = "update_#{parent_table}_#{child_table}_counter"
    execute %{
      CREATE OR REPLACE FUNCTION #{function_name}_on_insert() RETURNS TRIGGER AS $$
      BEGIN
        UPDATE #{parent_table} SET #{counter_column} = COALESCE((SELECT COUNT(id) FROM #{child_table} GROUP BY #{foreign_column} HAVING #{foreign_column} = NEW.#{foreign_column}), 0) WHERE (#{parent_table}.id = NEW.#{foreign_column});
        RETURN NULL;
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE FUNCTION #{function_name}_on_delete() RETURNS TRIGGER AS $$
      BEGIN
        UPDATE #{parent_table} SET #{counter_column} = COALESCE((SELECT COUNT(id) FROM #{child_table} GROUP BY #{foreign_column} HAVING #{foreign_column} = OLD.#{foreign_column}), 0) WHERE (#{parent_table}.id = OLD.#{foreign_column});
        RETURN NULL;
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE FUNCTION #{function_name}_on_update() RETURNS TRIGGER AS $$
      BEGIN
        IF NEW.#{foreign_column} <> OLD.#{foreign_column} THEN
          UPDATE #{parent_table} SET #{counter_column} = COALESCE((SELECT COUNT(id) FROM #{child_table} GROUP BY #{foreign_column} HAVING #{foreign_column} = NEW.#{foreign_column}), 0) WHERE (#{parent_table}.id = NEW.#{foreign_column});
          UPDATE #{parent_table} SET #{counter_column} = COALESCE((SELECT COUNT(id) FROM #{child_table} GROUP BY #{foreign_column} HAVING #{foreign_column} = OLD.#{foreign_column}), 0) WHERE (#{parent_table}.id = OLD.#{foreign_column});
        END IF;
        RETURN NULL;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER _001_#{function_name}_on_insert AFTER INSERT ON #{child_table} FOR EACH ROW EXECUTE PROCEDURE #{function_name}_on_insert();
      CREATE TRIGGER _001_#{function_name}_on_update AFTER UPDATE ON #{child_table} FOR EACH ROW EXECUTE PROCEDURE #{function_name}_on_update();
      CREATE TRIGGER _001_#{function_name}_on_delete AFTER DELETE ON #{child_table} FOR EACH ROW EXECUTE PROCEDURE #{function_name}_on_delete();
    }
  end
end
