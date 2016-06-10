class CreateDuties < ActiveRecord::Migration
  def change
    create_table :duties do |t|
      t.references :discipline, foreign_key: true, null: false
      t.references :document, foreign_key: true
      t.text :name, null: false

      t.index [:discipline_id, :document_id, :name], unique: true, name: :duties_index

      t.timestamps null: false
    end
  end
end
