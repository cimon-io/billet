# frozen_string_literal: true

RSpec.shared_context 'limited database queries' do |args|
  it 'avoids (n+1) DB queries' do
    expect { result }.to make_database_queries(args)
  end
end
