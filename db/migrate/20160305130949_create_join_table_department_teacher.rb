class CreateJoinTableDepartmentTeacher < ActiveRecord::Migration
  def change
    create_join_table :departments, :teachers do |t|
      t.index [:department_id, :teacher_id], unique: true
      # t.index [:teacher_id, :department_id]
    end
  end
end
