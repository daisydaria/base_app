class StudentHonor < ActiveRecord::Base
	has_attached_file :attach
	do_not_validate_attachment_file_type :attach
	belongs_to :student
end
