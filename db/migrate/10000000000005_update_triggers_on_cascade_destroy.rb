class UpdateTriggersOnCascadeDestroy < ActiveRecord::Migration[5.1]
  def up
    create_or_replace_touch_functions_and_triggers
  end

  def down
    drop_touch_functions_and_triggers
  end

  private

  def table_names
    (tables - %w[schema_migrations ar_internal_metadata]).sort
  end

  def create_touch_trigger_for(table_name)
    execute %(
      CREATE TRIGGER touch_dependent_tables_on_destroy BEFORE DELETE ON #{table_name}
      FOR EACH ROW EXECUTE PROCEDURE touch_for_#{table_name}_on_destroy();
    )
  end

  def drop_touch_functions_and_triggers
    table_names.each do |table_name|
      execute %(
        DROP TRIGGER IF EXISTS touch_dependent_tables_on_destroy ON #{table_name};
        DROP FUNCTION IF EXISTS touch_for_#{table_name}_on_destroy();
      )
    end
  end

  def create_or_replace_touch_functions_and_triggers
    drop_touch_functions_and_triggers

    table_names.each do |table_name|
      options = touch_options_for(table_name)
      next if options.none?

      execute %(
        CREATE OR REPLACE FUNCTION touch_for_#{table_name}_on_destroy() RETURNS TRIGGER AS $$
        BEGIN#{dynamic_touch_query(options)}
          RETURN OLD;
          EXCEPTION
            WHEN foreign_key_violation THEN
              RETURN OLD;
        END;
        $$ LANGUAGE plpgsql;
      )

      create_touch_trigger_for(table_name)
    end
  end

  def touch_options_for(table_name)
    execute %(
      SELECT ccu.table_name AS foreign_table_name, kcu.column_name AS column_name
      FROM information_schema.table_constraints AS tc
        JOIN information_schema.key_column_usage AS kcu
        ON tc.constraint_name = kcu.constraint_name
        JOIN information_schema.constraint_column_usage AS ccu
        ON ccu.constraint_name = tc.constraint_name
      WHERE constraint_type = 'FOREIGN KEY' AND tc.table_name = '#{table_name}'
      ORDER BY ccu.table_name
    )
  end

  def dynamic_touch_query(options)
    options.inject('') do |query, opts|
      query << %(
          UPDATE #{opts['foreign_table_name']} SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.#{opts['column_name']};)
    end
  end
end
