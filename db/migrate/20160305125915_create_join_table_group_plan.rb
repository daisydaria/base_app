class CreateJoinTableGroupPlan < ActiveRecord::Migration
  def change
    create_join_table :groups, :plans do |t|
      t.index [:group_id, :plan_id], unique: true
      # t.index [:plan_id, :group_id]
    end
  end
end
