class AddStudentIdToStudentHonors < ActiveRecord::Migration
  def change
    add_column :student_honors, :student_id, :integer
  end
end
