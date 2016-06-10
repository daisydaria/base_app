class GroupsController < ApplicationController
  before_action :set_group, except: [:create, :update, :index, :new]
  before_action :test_operator_rights, except: [:index, :show]
  protect_from_forgery :except => [:create_student]
  
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @student = Student.new 
  end

  def actual_students
    result = {query: params["query"]}
    ids = @group.students.map{|x| x.id}
    # todo: Непонятно почему не работает с пусым массивом..
    ids = [-1] if ids.empty?
    @students = []
    #@students = Student.where("lower(concat(l_n, f_n, s_n)) like ?", "%#{params[:query].remove(/\s/).mb_chars.downcase.to_s}")
    #костыль
    Student.where("id not in (?)", ids).map do |student|
      @full_name = "#{student.l_n}#{student.f_n}#{student.s_n}".mb_chars.downcase.to_s
      @students << student if @full_name.index(params[:query].mb_chars.downcase.to_s.remove(/\s/))
    end
    result["suggestions"] = @students.map do |student| 
      {
        value: "#{student.l_n} #{student.f_n} #{student.s_n}", 
        data: student.id
      }
    end
    render json: result
  end

  def add_student
    @group.students << Student.find(params[:student_id])
    render nothing: true
  end

  def remove_student
    @group.students.delete(Student.find(params[:student_id]))
    render nothing: true
  end

  def create_student
    @student = Student.new(student_params)
    if @student.save
      @group.students << @student
      render json: @student
    else
      render json: @student.errors.full_messages, status: 404 #рандомный код HTTP ошибки, чтобы сработала функция аякс error
    end
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Новая группа создана!' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Группа обновлена!' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Группа удалена!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:title, :course, :semester)
    end

    def student_params
      params.require(:student).permit(:l_n, :f_n, :s_n, :birth, :studbook)
    end
end
