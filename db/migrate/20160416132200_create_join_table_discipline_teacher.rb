class CreateJoinTableDisciplineTeacher < ActiveRecord::Migration
  def change
    create_join_table :disciplines, :teachers do |t|
      # t.index [:discipline_id, :teacher_id]
      # t.index [:teacher_id, :discipline_id]
    end
  end
end
