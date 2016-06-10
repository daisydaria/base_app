class StudentWorksController < ApplicationController
  
	def accept
		@work = StudentWork.find(params[:id])
		@work.update_attribute(:status, StudentWork::STATUS_SUCCESS)
		redirect_to available_works_path
	end

	def reject
		@work = StudentWork.find(params[:id])
		@work.update_attribute(:status, StudentWork::STATUS_ERROR)
		redirect_to available_works_path
	end

	def show
		@student_work = StudentWork.find(params[:id])
	end

	def edit
		@student = current_user.student
		@group = @student.group if @student
		@plan = @group.plans.first if @group
		@disciplines = @plan.disciplines if @plan
		@disciplines ||= []
		@work = StudentWork.find(params[:id])
	end

	def new
		@work = StudentWork.new
		@student = current_user.student
		@group = @student.group if @student
		@plan = @group.plans.first if @group
		@disciplines = @plan.disciplines if @plan
		@disciplines ||= []
	end

	def update
		@work = StudentWork.find(params[:id])
		if (@work.update(student_work_params))
			redirect_to my_works_students_path
		else
			render :edit
		end
	end

	def create
		@student = current_user.student
		@group = @student.group if @student
		@plan = @group.plans.first if @group
		@disciplines = @plan.disciplines if @plan
		@disciplines ||= []
		@work = StudentWork.new(student_work_params)
		@work.student = current_user.student if current_user
		@work.status = "На рассмотрении"
		if (@work.save)
			redirect_to my_works_students_path
		else
			render :new
		end
	end

	def destroy
		@work = StudentWork.find(params[:id])
		unless is_student? || current_user.student.id == @work.student_id
		 	access_denied!
		 	return
		end 
		@work.destroy
		redirect_to my_works_students_path
	end

	private

		def student_work_params
			params[:student_work].permit!
		end
end
