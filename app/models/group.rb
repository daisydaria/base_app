class Group < ActiveRecord::Base
	belongs_to :department
	has_many :students
	has_and_belongs_to_many :plans

	validates :title, presence: true, uniqueness: true
	validates :course, presence: true
	validates :semester, presence: true
end
