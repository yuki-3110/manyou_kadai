class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)

  def index
    @tasks = Task.all.order(created_at: :desc)
    # @tasks = Task.where(status: params[:status])
    @tasks = Task.all.order(deadline: :desc) if params[:sort_expired]

    @tasks = Task.all.order(priority: :asc) if params[:sort2_expired]
    @tasks = Task.search_with_priority(params[:priority]) if params[:priority].present?

    # @tasks = @tasks.search_with_priority(params[:priority])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    render :new and return if params[:back]
    if @task.save
      redirect_to tasks_path, notice: "タスクを追加しました！"
    else 
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  # def search
  #   @tasks = Task.where(priority: params[:priority])
  #   # status_ids = Task.where("status = ?", params[:status]).pluck(:id)
  # end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end

end
