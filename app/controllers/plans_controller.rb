class PlansController < ApplicationController
  before_action :set_plan, except: [:index, :create, :new]
  before_action :test_operator_rights, except: [:index, :show]
  before_action :set_forms, only: [:edit, :create, :new, :update]
  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.all
  end

  def actual_groups
    result = {query: params["query"]}
    ids = @plan.groups.map{|x| x.id}
    # todo: Непонятно почему не работает с пусым массивом..
    ids = [-1] if ids.empty?
    @groups = []
    #костыль
    Group.where("id not in (?)", ids).map do |group|
      @groups << group if group.title.mb_chars.downcase.to_s.index(params[:query].mb_chars.downcase.to_s.remove(/\s/))
    end
    result["suggestions"] = @groups.map do |group| 
      {
        value: group.title, 
        data: group.id
      }
    end
    render json: result
  end

  def add_group
    @plan.groups << Group.find(params[:group_id])
    render nothing: true
  end

  def remove_group
    @plan.groups.delete(Group.find(params[:group_id]))
    render nothing: true
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)

    respond_to do |format|
      if @plan.save
        format.html { redirect_to plans_path, notice: 'План создан!' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to plans_path, notice: 'План обновлен!' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'План удален!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      @plan_params = params.require(:plan).permit(:specialty_id, :learn_form, :learn_period, :discipline_ids)
      @plan_params[:discipline_ids] = params[:plan]["discipline_ids"]
      @plan_params
    end
    
    def set_forms
      @learn_forms = %w[очная заочная очно-заочная]
    end
end
