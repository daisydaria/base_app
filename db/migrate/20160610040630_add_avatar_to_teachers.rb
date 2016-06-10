class AddAvatarToTeachers < ActiveRecord::Migration
  def change
  	add_column :teachers, :avatar, :attachment
  end
end
