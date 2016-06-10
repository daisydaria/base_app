class WelcomeController < ApplicationController
  skip_before_action :check_app_auth, :get_current_role
  before_action :require_login, only: :destroy
  
  def index
    if @current_user.blank?
      render('empty_index')        
    elsif is_student?
      @works = current_user.student.student_works
      render('students_index')
    elsif is_teacher?
      render('teacher_index')
    else
      render('index')
    end
  end 

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember])
      redirect_back_or_to(root_path, notice: 'Вход выполнен')
    else
      flash[:danger] = "Неверный #{User.human_attribute_name(:email).mb_chars.downcase} или
#{User.human_attribute_name(:password).mb_chars.downcase}"
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: 'Сеанс работы в системе завершен')
  end  
end
