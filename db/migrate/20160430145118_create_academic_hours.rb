class CreateAcademicHours < ActiveRecord::Migration
  def change
    create_table :academic_hours do |t|
      t.integer :teacher_id
      t.integer :group_id
      t.integer :discipline_id
      
      t.timestamps null: false
    end
  end
end
