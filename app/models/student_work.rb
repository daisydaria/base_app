class StudentWork < ActiveRecord::Base
	belongs_to :student
	belongs_to :discipline
	STATUS_TEMP = "На рассмотрении"
	STATUS_ERROR = "Не зачтено"
	STATUS_SUCCESS = "Зачтено"
	
	validates :title, :description, :discipline_id, presence: true
	has_attached_file :attach
	do_not_validate_attachment_file_type :attach
end
