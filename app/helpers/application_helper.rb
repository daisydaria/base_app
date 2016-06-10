module ApplicationHelper
	def need_works
	    if is_student?
	      @discipline_ids = current_user.student.student_works.select(:discipline_id).where("status = ? OR status = ?", StudentWork::STATUS_SUCCESS, StudentWork::STATUS_TEMP).map{|x| x.discipline_id}
	      @discipline_ids.push -1
        @group = current_user.student.group
        @plan = @group.plans.first if @group
        @disciplines = @plan.disciplines.where("id not in (?)", @discipline_ids) if @plan
        @disciplines ||= []
	      @str = ""
	      @disciplines.each do |x|
      	  	@str += x.title + "<br>"
      	   end
	    end
  	end

  	def available_teacher_works
  		if is_teacher?
  			@discipline_ids = current_user.teacher.academic_hours.map{|x| x.discipline.id}
  			@works = StudentWork.where("discipline_id in (?) and status = ?", @discipline_ids, StudentWork::StudentWork::STATUS_TEMP)
  		end
  	end
end
