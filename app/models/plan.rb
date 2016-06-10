class Plan < ActiveRecord::Base

 #    has_and_belongs_to_many :groups
	has_many :disciplines
	belongs_to :specialty
	has_and_belongs_to_many :groups
	# has_many :disciplines, inverse_of: :plan
 #        accepts_nested_attributes_for :disciplines, allow_destroy: true #позволяет принимать атрибуты от дисциплины

 	validates :specialty_id, presence: true
 	validates :learn_form, presence: true
 	validates :learn_period, presence: true
	# validates :form, presence: true
	# validates :period, presence: true
end
