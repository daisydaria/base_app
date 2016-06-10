class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :form, :null => false
      t.integer :period, :null => false

      t.references :specialty, index: true

      t.timestamps null: false
    end
  end
end
