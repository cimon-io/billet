class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.belongs_to :company
      t.timestamps
    end
  end
end
