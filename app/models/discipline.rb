class Discipline < ActiveRecord::Base
	belongs_to :plan
	has_and_belongs_to_many :students
	has_and_belongs_to_many :teachers

	has_many :duties
	has_many :student_works

	validates :title, presence: true
	validates :tip, presence: true
	
	def is_done?
	  return self.student_works.select{ |w| w.status == StudentWork::STATUS_SUCCESS }.size > 0
	end
end
