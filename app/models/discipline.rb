class Discipline < ActiveRecord::Base
	belongs_to :plan
	has_and_belongs_to_many :students
	has_and_belongs_to_many :teachers

	has_many :duties

	validates :title, presence: true
	validates :tip, presence: true
end
