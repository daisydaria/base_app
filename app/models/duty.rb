class Duty < ActiveRecord::Base
  belongs_to :discipline
  belongs_to :document
  belongs_to :student
end
