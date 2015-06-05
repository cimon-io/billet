class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users  do |t|
      t.string :remember_token, limit: 128, null: false
      t.timestamps null: false
    end

    create_table :user_identities do |t|
      t.belongs_to :user

      t.string :token

      t.string :email
      t.string :avatar_url
      t.string :name
      t.string :uid, null: false
      t.string :provider, null: false
      t.timestamps null: false
    end
  end
end
