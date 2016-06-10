class AddUserToTeacher < ActiveRecord::Migration
  def change
    
	add_reference :teachers, :user, foreign_key: true
	add_index :teachers, :user_id, unique: true
  end
end
