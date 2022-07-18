class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)

  def index
    @tasks = current_user.tasks
    @tasks = @tasks.order(deadline: :desc) if params[:sort_expired]
    @tasks = @tasks.order(priority: :asc) if params[:sort_priority]


    if params[:task].present?
      if params[:task][:status].present? && params[:task][:title].present?
        @tasks = @tasks.search_with_both(params[:task][:status], params[:task][:title])
      elsif params[:task][:status].present?
        @tasks = @tasks.search_with_status(params[:task][:status])
      elsif params[:task][:title].present?
        @tasks = @tasks.search_with_title(params[:task][:title])
      elsif params[:task][:label_id].present?
        @tasks = @tasks.joins(:labels).search_with_label(params[:task][:label_id])
      end
    end
    @tasks = @tasks.order(created_at: :desc).page(params[:page]).per(2)
  end


  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
    render :new and return if params[:back]
    if @task.save
      redirect_to tasks_path, notice: "タスクを追加しました！"
    else 
      render :new
    end
  end

  def show
    # @middle = current_user.middles.find_by(task_id: @task.id)
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
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority, :user_id, { label_ids: [] } )
  end

end
