class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users  do |t|
      t.timestamps null: false
      t.string :email, null: false
      t.string :encrypted_password, limit: 128, null: false
      t.string :confirmation_token, limit: 128
      t.string :remember_token, limit: 128, null: false

      t.belongs_to :company
    end

    add_index :users, :email
    add_index :users, :remember_token
    add_index :users, :company_id
  end

  def self.down
    drop_table :users
  end
end
