class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false, unique: true
      t.timestamps
    end
    add_index :companies, :name, unique: true

    create_table :company_users do |t|
      t.belongs_to :user
      t.belongs_to :company

      t.timestamps null: false
    end
  end
end
