# frozen_string_literal: true

# supported_version: Rails::VERSION::STRING '~> 6.0.3'

module ActiveRecord
  module Persistence
    # https://github.com/rails/rails/blob/v6.0.3.2/activerecord/lib/active_record/persistence.rb#L929-L943
    def _create_record(attribute_names = self.attribute_names)
      attribute_names = attributes_for_create(attribute_names)

      new_id, *affected_rows = self.class._insert_record(
        attributes_with_values(attribute_names)
      )

      self.id ||= new_id if @primary_key

      Hash[ApplicationRecord.custom_returning_columns(self.class.quoted_table_name, :create).take(affected_rows.size).zip(affected_rows)].each do |column_name, value|
        public_send("#{column_name}=", self.class.attribute_types[column_name.to_s].deserialize(value)) if value
      end

      @new_record = false

      yield(self) if block_given?

      id
    end
    private :_create_record

    # https://github.com/rails/rails/blob/v6.0.3.2/activerecord/lib/active_record/persistence.rb#L911-L925
    def _update_record(attribute_names = self.attribute_names)
      attribute_names = attributes_for_update(attribute_names)

      if attribute_names.empty?
        affected_rows = []
        @_trigger_update_callback = true
      else
        affected_rows = _update_row(attribute_names)
        @_trigger_update_callback = affected_rows.any?
      end

      Hash[ApplicationRecord.custom_returning_columns(self.class.quoted_table_name, :update).take(affected_rows.size).zip(affected_rows)].each do |column_name, value|
        public_send("#{column_name}=", self.class.attribute_types[column_name.to_s].deserialize(value))
      end

      yield(self) if block_given?

      affected_rows.none? ? 0 : 1
    end
    private :_update_record
  end

  module ConnectionAdapters
    module PostgreSQL
      module DatabaseStatements
        # https://github.com/rails/rails/blob/v6.0.2.2/activerecord/lib/active_record/connection_adapters/postgresql/database_statements.rb#L110-L113
        def exec_update(sql, name = nil, binds = [])
          execute_and_clear(sql_with_returning(sql), name, binds) { |result| Array.wrap(result.values.first) }
        end

        # https://github.com/rails/rails/blob/v6.0.2.2/activerecord/lib/active_record/connection_adapters/abstract/database_statements.rb#L164-L169
        def insert(arel, name = nil, pk = nil, _id_value = nil, sequence_name = nil, binds = [])
          sql, binds = to_sql_and_binds(arel, binds)
          exec_insert(sql, name, binds, pk, sequence_name).rows.first
        end
        alias create insert

        # https://github.com/rails/rails/blob/v6.0.3.2/activerecord/lib/active_record/connection_adapters/postgresql/database_statements.rb#L115-L128
        def sql_for_insert(sql, pk, binds) # :nodoc:
          table_ref = extract_table_ref_from_insert_sql(sql)
          if pk.nil?
            # Extract the table from the insert sql. Yuck.
            pk = primary_key(table_ref) if table_ref
          end

          returning_columns = quote_returning_column_names(table_ref, pk, :create)
          if returning_columns.any?
            sql = "#{sql} RETURNING #{returning_columns.join(', ')}"
          end

          super
        end

        # No source in original repo
        def quote_returning_column_names(table_ref, pk, action)
          returning_columns = []
          returning_columns << pk if suppress_composite_primary_key(pk)
          returning_columns += ApplicationRecord.custom_returning_columns(table_ref, action)
          returning_columns.map { |column| quote_column_name(column) }
        end

        # No source in original repo
        def sql_with_returning(sql)
          table_ref = extract_table_ref_from_update_sql(sql)

          returning_columns = quote_returning_column_names(table_ref, nil, :update)

          return sql if returning_columns.blank?

          "#{sql} RETURNING #{returning_columns.join(', ')}"
        end

        # No source in original repo
        def extract_table_ref_from_update_sql(sql)
          sql[/update\s("[A-Za-z0-9_."\[\]\s]+"|[A-Za-z0-9_."\[\]]+)\s*set/im]
          Regexp.last_match(1)&.strip
        end
      end
    end
  end
end
