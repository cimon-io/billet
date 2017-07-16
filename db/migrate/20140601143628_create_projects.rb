class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.belongs_to :company
      t.timestamps
    end
  end
end
