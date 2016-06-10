#для связи преподователь - группа+дисциплина
class AcademicHour < ActiveRecord::Base
	belongs_to :teacher
	belongs_to :discipline
	belongs_to :group
end
