class SorceryFile < ActiveRecord::Migration
  def change
    add_column :users, :file, :string
  end
end
