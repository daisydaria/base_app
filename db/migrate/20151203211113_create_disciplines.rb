 class CreateDisciplines < ActiveRecord::Migration
  def change
    create_table :disciplines do |t|
      t.string :title, :null => false
      t.text :tip, :null => false

      t.references :plan, index: true
      t.references :duty, index: true

      t.timestamps null: false
    end
  end
end
