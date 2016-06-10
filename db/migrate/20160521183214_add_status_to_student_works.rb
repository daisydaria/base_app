class AddStatusToStudentWorks < ActiveRecord::Migration
  def change
    add_column :student_works, :status, :string
  end
end
