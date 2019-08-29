class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :remember_token, limit: 128, null: false

      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }, null: false
      t.datetime :updated_at, default: -> { 'CURRENT_TIMESTAMP' }, null: false
    end

    create_table :user_identities do |t|
      t.belongs_to :user

      t.string :token
      t.string :email
      t.string :avatar_url
      t.string :name
      t.string :uid, null: false
      t.string :provider, null: false
      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }, null: false
      t.datetime :updated_at, default: -> { 'CURRENT_TIMESTAMP' }, null: false
    end
  end
end
