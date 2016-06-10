class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.integer :num, :null => false, :limit => 5
      t.string :title, :null => false
      t.string :superunit
      t.index :num, :unique => true

      t.timestamps null: false
    end
  end
end
