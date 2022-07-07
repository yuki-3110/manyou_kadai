class UsersController < ApplicationController
  skip_before_action :login_required, only: %i(new create)
  before_action :set_user, only: %i(show edit update)
  before_action :user_check, only: %i(show)

  def new
    redirect_to tasks_path, notice: "すでにアカウントは登録されています" if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
    @user_tasks = @user.tasks
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_check
    if current_user != @user
      redirect_to tasks_path, notice: "他人のプロフィールの確認はできません"
    end
  end

end
