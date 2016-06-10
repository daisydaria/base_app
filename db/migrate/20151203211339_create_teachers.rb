class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :lname, :null => false
      t.string :fname, :null => false
      t.string :sname
      t.date :birth, :null => false
      t.string :degree, :null => false
      t.text :rank, :null => false
      t.text :post, :null => false

      t.timestamps null: false
    end
  end
end
