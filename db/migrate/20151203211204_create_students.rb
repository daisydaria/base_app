class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :l_n, :null => false
      t.string :f_n, :null => false
      t.string :s_n
      t.date :birth, :null => false
      t.integer :studbook, :null => false
      t.index :studbook, :unique => true
      t.attachment :avatar

      t.references :group, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
