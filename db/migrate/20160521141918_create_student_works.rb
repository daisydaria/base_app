class CreateStudentWorks < ActiveRecord::Migration
  def change
    create_table :student_works do |t|
      t.integer :student_id
      t.string :title
      t.string :description
      t.boolean :visited
      t.attachment :attach
      t.integer :discipline_id

      t.timestamps null: false
    end
  end
end
