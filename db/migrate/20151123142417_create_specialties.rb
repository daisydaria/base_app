class CreateSpecialties < ActiveRecord::Migration
  def change
    create_table :specialties do |t|
      t.string :code, :null => false, :limit => 10
      t.string :gen, :null => false
      t.string :title, :null => false
      t.string :level, :null => false
      t.index :code, :unique => true

      t.timestamps null: false
    end
  end
end
