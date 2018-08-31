class UserApplications < ActiveRecord::Migration[5.1]
  def change
    create_table 'user_applications' do |t|
      t.belongs_to :user
      t.string :token, null: false

      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }, null: false
      t.datetime :updated_at, default: -> { 'CURRENT_TIMESTAMP' }, null: false
    end
    add_index :user_applications, :token, unique: true
  end
end
