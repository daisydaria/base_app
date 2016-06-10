class CreateStudentHonors < ActiveRecord::Migration
  def change
    create_table :student_honors do |t|
      t.string :title
      t.string :description
      t.attachment :attach

      t.timestamps null: false
    end
  end
end
