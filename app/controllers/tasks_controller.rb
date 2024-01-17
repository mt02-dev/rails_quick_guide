class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy ]

  def index
    # @tasks = Task.where(user_id: current_user.id)
  end

  def show

  end

  def new
    @task = Task.new(flash[:task])
  end

  def create
    if @task.save
      flash[:notice] = "タスク名:#{@task.name}を登録しました。"
      redirect_to tasks_path(:task)
      # redirect_to tasks_path, notice: "タスク名:#{task.name}を登録しました。"
    else
      redirect_back fallback_location: new_task_path, flash: {
        task: @task,
        error_messages: task.errors.full_messages
      }
    end
  end
  
  def edit
  
  end

  def update
    task = current_user.tasks.find(params[:id])
    if task.update(task_params)
      redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
    else
      redirect_back fallback_location: edit_task_path, flash: {
        task: task,
        error_messages: task.errors.full_messages
      }
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, status: :see_other, notice: "タスク「#{task.name}」を削除しました。"
  end

  private
  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_tasks
    @tasks = current_user.tasks.order(created_at: :desc)
  end
end
