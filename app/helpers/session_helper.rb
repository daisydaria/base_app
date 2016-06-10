module SessionHelper
  def is_operator?
    current_user && current_user.role_users.any?{ |x| x.role.name == 'Оператор учебного центра' }
  end

  def is_admin?()
    current_user && current_user.role_users.any?{ |x| x.role.name == 'Администратор' }
  end

  def is_student?
  	current_user && current_user.role_users.any?{ |x| x.role.name == 'Студент' }
  end

  def is_teacher?
  	current_user && current_user.role_users.any?{ |x| x.role.name == 'Преподаватель' }
  end
end