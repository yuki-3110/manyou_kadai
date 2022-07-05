class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)

  def index
    @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(2)

    @tasks = Task.all.order(deadline: :desc).page(params[:page]).per(2) if params[:sort_expired]

    @tasks = Task.all.order(priority: :asc).page(params[:page]).per(2) if params[:sort2_expired]

    if params[:task].present?
      if params[:task][:status].present? && params[:task][:title].present?
        @tasks = Task.search_with_both(params[:task][:status], params[:task][:title])
      elsif params[:task][:status].present?
        @tasks = Task.search_with_status(params[:task][:status])
      elsif params[:task][:title].present?
        @tasks = Task.search_with_title(params[:task][:title])
      end
      @tasks = @tasks.page(params[:page]).per(2)
    end
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

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end

end
