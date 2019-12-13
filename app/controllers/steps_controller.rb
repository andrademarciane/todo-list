class StepsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_step, only: [:edit, :update, :destroy]

  # GET /steps/new
  def new
    @step = Step.new(task_id: params[:task_id].to_i)
    respond_to do |format|
      format.js { render 'new.js.erb' }
    end
  end

  # GET /steps/1/edit
  def edit
    respond_to do |format|
      format.js { render 'edit.js.erb' }
    end
  end

  # POST /steps
  # POST /steps.json
  def create
    @step = Step.new(step_params)

    respond_to do |format|
      if @step.save
        @steps = Step.where(task_id: @step.task_id).order(:id)
        format.html { redirect_to edit_board_path(@step.task.board_id) }
        format.js {}
        format.json { render :show, status: :created, location: @step }
      else
        format.html { redirect_to root_path }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /steps/1
  # PATCH/PUT /steps/1.json
  def update
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to @step, notice: 'steps was successfully updated.' }
        format.js {}
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steps/1
  # DELETE /steps/1.json
  def destroy
    @step.destroy
    respond_to do |format|
      @steps = Step.where(task_id: @step.task_id).order(:id)
      format.html { redirect_to steps_url, notice: 'steps was successfully destroyed.' }
      format.js {}
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_step
    @step = Step.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def step_params
    params.require(:step).permit(:task_id, :name)
  end
end