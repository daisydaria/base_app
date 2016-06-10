class TeachersController < ApplicationController
  before_action :set_teacher, only: [:add_hour, :show, :edit, :update, :destroy,:get_avatar]
  before_action :test_operator_rights, except: [:index, :show, :available_works, :get_avatar]
  before_action :set_positions, only: [:edit, :create, :new, :update]
  include ApplicationHelper

  def available_works
    available_teacher_works
  end

  # GET /teachers
  # GET /teachers.json
  def index
    @teachers = Teacher.all
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
  end

  def get_avatar
    type = :big
    type = params['type'] if params.has_key?(:type)
    send_file @teacher.avatar.path(type)
  end
  
  def add_hour
    if AcademicHour.find_by(teacher_id: @teacher.id, group_id: params[:group_id], discipline_id: params[:discipline_id])
      render nothing: true, status: 404
    else
      @hour = AcademicHour.create(teacher_id: @teacher.id, group_id: params[:group_id], discipline_id: params[:discipline_id])
      render json: @hour
    end
  end

  def remove_hour
    AcademicHour.find(params[:hour_id]).delete
    render nothing: true
  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new
  end

  # GET /teachers/1/edit
  def edit
  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to @teacher, notice: 'Преподаватель создан!' }
        format.json { render :show, status: :created, location: @teacher }
      else
        format.html { render :new } 
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teachers/1
  # PATCH/PUT /teachers/1.json
  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to teachers_path, notice: 'Преподаватель обновлен!' }
        format.json { render :show, status: :ok, location: @teacher }
      else
        format.html { render :edit }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    @teacher.destroy
    respond_to do |format|
      format.html { redirect_to teachers_url, notice: 'Преподаватель удален!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:teacher).permit(:lname, :fname, :sname, :birth, :degree, :rank, :post)
    end

    def set_positions
      @positions = %w[Ассистент Профессор Доцент]
    end
end
