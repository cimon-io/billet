class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false, unique: true
      t.integer :projects_count, null: false, default: 0

      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }, null: false
      t.datetime :updated_at, default: -> { 'CURRENT_TIMESTAMP' }, null: false
    end
    add_index :companies, :name, unique: true

    create_table :company_users do |t|
      t.belongs_to :user
      t.belongs_to :company

      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }, null: false
      t.datetime :updated_at, default: -> { 'CURRENT_TIMESTAMP' }, null: false
    end
  end
end
