class AddStudentIdToDuties < ActiveRecord::Migration
  def change
    add_column :duties, :student_id, :integer
  end
end
