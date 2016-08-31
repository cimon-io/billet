class UserApplications < ActiveRecord::Migration
  def change
    create_table 'user_applications' do |t|
      t.belongs_to  :user
      t.string      "token", :null => false
      t.timestamps
    end
    add_index :user_applications, :token, unique: true
  end
end
