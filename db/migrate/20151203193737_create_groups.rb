class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title, :null => false
      t.integer :course, :null => false
      t.integer :semester, :null => false
      t.index :title, :unique => true

      t.references :department, index: true

      t.timestamps null: false
    end
  end
end
