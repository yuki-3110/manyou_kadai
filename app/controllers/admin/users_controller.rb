class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: %i(index new create)
  # before_action :if_not_admin
  before_action :set_user, only: %i(show edit destroy)

  def index
    @users = User.all.includes(:tasks)
  end

  private
  # def if_not_admin
  #   redirect_to root_path, notice: "管理者以外はアクセスできません" unless current_user.admin?
  # end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
