class TasksController < ApiController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  def index
    render json: current_user.tasks
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = current_user.tasks.create!(task_params)
    render json: @task, status: :created, location: @task
  end

  # PATCH/PUT /tasks/1
  def update
    render json: @task.update!(task_params)
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    head :no_content
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:user_id, :title, :description, :done, :due_date)
  end
end
