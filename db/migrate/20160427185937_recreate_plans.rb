class RecreatePlans < ActiveRecord::Migration
  def change
  	drop_table :plans
  	create_table :plans do |t|
  		t.belongs_to :specialty
  		t.string :learn_form
  		t.integer :learn_period
  	end
  end
end
