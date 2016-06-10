class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :get_avatar, :works, :honors]
  before_action :test_operator_rights, except: [:show, :index, :works, :my_works, :honors, :my_honors, :get_avatar]
  
  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  def my_works
    @works = current_user.student.student_works
  end

  def honors
  end

  def my_honors
    @honors = current_user.student.student_honors
  end

  def show
  end

  # GET /students/1
  # GET /students/1.json

  def get_avatar
    type = :big
    type = params['type'] if params.has_key?(:type)
    send_file @student.avatar.path(type)
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  def register
    @student = Student.new
    render 'students/register'
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Студент создан!' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Студент обновлен!' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.delete
    # @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Студент удален!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:l_n, :f_n, :s_n, :birth, :studbook, :avatar)
    end
end
