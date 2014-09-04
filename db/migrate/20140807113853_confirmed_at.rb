class ConfirmedAt < ActiveRecord::Migration
  def change
    add_column :users, :confirmed_at, :datetime
  end
end
