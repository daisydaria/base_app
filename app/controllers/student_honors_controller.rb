class StudentHonorsController < ApplicationController
  
	def accept
	end

	def reject
	end

	def edit
		@honor = StudentHonor.find(params[:id])
	end

	def new
		@honor = StudentHonor.new
	end

	def update
		@honor = StudentHonor.find(params[:id])
		if (@honor.update(student_honor_params))
			redirect_to my_honors_students_path
		else
			render :edit
		end
	end

	def create
		@honor = StudentHonor.new(student_honor_params)
		@honor.student = current_user.student
		if (@honor.save)
			redirect_to my_honors_students_path
		else
			render :new
		end
	end

	def destroy
		@honor = StudentHonor.find(params[:id])
		unless is_student? || current_user.student.id == @honor.student_id
		 	access_denied!
		 	return
		end 
		@honor.destroy
		redirect_to my_honors_students_path
	end

	private

		def student_honor_params
			params[:student_honor].permit!
		end
end
