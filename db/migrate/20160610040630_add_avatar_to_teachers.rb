class AddAvatarToTeachers < ActiveRecord::Migration
  def change
  	add_attachment :teachers, :avatar
  end
end
