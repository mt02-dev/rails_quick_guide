class TasksController < ApplicationController
  before_action :set_tasks, only: %i[ show edit update destroy ]

  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distint: true).page(params[:page])

    # アクセスしてきたURLによってレスポンスを切り替える
    respond_to do |format|
      format.html
      # csvでアクセスしてきた場合にcsvファイルを返す
      format.csv { send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    end
  end

  def show

  end

  def new
    @task = Task.new(flash[:task])
  end

  def create
    @task = current_user.tasks.new(task_params) 

    if params[:back].present?
      render :new
      return
    end

    if @task.save
      # mail 送信 (利用する時は起動後にコンテナにgem mailcatcherをinstall)
      # TaskMailer.creation_email(@task).deliver_now
      SampleJob.perform_later
      flash[:notice] = "タスク名:#{@task.name}を登録しました。"
      redirect_to tasks_path(:task)
      # redirect_to tasks_path, notice: "タスク名:#{task.name}を登録しました。"
    else
      redirect_back fallback_location: new_task_path, flash: {
        task: @task,
        error_messages: @task.errors.full_messages
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
    head :no_content
    # redirect_to tasks_url, status: :see_other, notice: "タスク「#{@task.name}」を削除しました。"
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render new_task_path unless @task.valid?
  end

  def import
    current_user.tasks.import(params[:file])
    redirect_to tasks_url, notice: "タスクを追加しました"
  end

  private
  def task_params
    params.require(:task).permit(:name, :description, :image)
  end

  def set_tasks
    @task = current_user.tasks.find(params[:id]) 
  end
end
