# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'sql tests', type: :sql do
  after(:all) do
    ApplicationRecord.connection.execute("DROP FUNCTION IF EXISTS EXPECT_EQUAL(VARCHAR, ANYELEMENT, ANYELEMENT)")
    ApplicationRecord.connection.execute(
      <<-SQL
        DO $$
        DECLARE
          routine record;
        BEGIN
          FOR routine IN
            SELECT routine_name AS name
            FROM information_schema.routines
            WHERE
              routine_name LIKE 'rspec_%' AND
              routine_type ='FUNCTION' AND
              specific_schema='public'
          LOOP
            EXECUTE 'DROP FUNCTION ' || quote_ident(routine.name);
          END LOOP;
        END; $$;
      SQL
    )
  end

  before(:all) do
    ApplicationRecord.connection.execute(
      <<-SQL
        DROP FUNCTION IF EXISTS EXPECT_EQUAL(VARCHAR, ANYELEMENT, ANYELEMENT);
        CREATE OR REPLACE FUNCTION EXPECT_EQUAL(b VARCHAR, r ANYELEMENT, m ANYELEMENT) RETURNS void LANGUAGE plpgsql AS $$
        BEGIN
          ASSERT m = r, b;
        END; $$;
      SQL
    )

    ApplicationRecord.connection.execute(
      <<-SQL
        DO $$
        DECLARE
          routine record;
        BEGIN
          FOR routine IN
            SELECT routine_name AS name
            FROM information_schema.routines
            WHERE
              routine_name LIKE 'rspec_%' AND
              routine_type ='FUNCTION' AND
              specific_schema='public'
          LOOP
            EXECUTE 'DROP FUNCTION ' || quote_ident(routine.name);
          END LOOP;
        END $$ LANGUAGE plpgsql;
      SQL
    )
  end

  context "sql tests", type: :sql do
    Dir[File.expand_path('**/*_spec.sql', __dir__)].map do |path|
      content = IO.read(path).strip
      basename = Pathname.new(path)
                         .relative_path_from(Rails.root.join('spec', 'sql'))
                         .to_s
                         .gsub('/', '__')
                         .gsub(/_spec.sql\z/, '')
      OpenStruct.new(path: path.to_s, content: content, empty?: content.empty?, basename: basename, function_name: "rspec_#{basename}")
    end.each do |f|
      context("test #{f.basename}", skip: f.empty?) do
        before do
          DatabaseCleaner.clean_with(:truncation)
          ApplicationRecord.connection.execute("CREATE OR REPLACE FUNCTION #{f.function_name}() RETURNS varchar LANGUAGE plpgsql AS $$ #{f.content} $$;")
        end

        after do
          begin
            ApplicationRecord.connection.execute("DROP FUNCTION IF EXISTS #{f.function_name}()")
          rescue ActiveRecord::StatementInvalid
            nil
          end
        end
        it('should return ok') { expect(ApplicationRecord.connection.execute("SELECT #{f.function_name}()").to_a.first[f.function_name]).to eq('ok') }
      end
    end
  end
end
