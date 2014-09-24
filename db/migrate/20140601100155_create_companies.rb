class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false, unique: true
      t.string :subdomain, null: false, unique: true
      t.timestamps
    end
    add_index :companies, :name, unique: true
  end
end
