class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])

  end

  def new
    @task = Task.new(flash[:task])
  end

  def create
    task = Task.new(task_params)
    if task.save
      flash[:notice] = "タスク名:#{task.name}を登録しました。"
      redirect_to tasks_path(:task)
      # redirect_to tasks_path, notice: "タスク名:#{task.name}を登録しました。"
    else
      redirect_back fallback_location: new_task_path, flash: {
        task: task,
        error_messages: task.errors.full_messages
      }
    end
  end
  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
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
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, status: :see_other, notice: "タスク「#{task.name}」を削除しました。"
  end

  private
  def task_params
    params.require(:task).permit(:name, :description)
  end

end
