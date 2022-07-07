class SessionsController < ApplicationController
  skip_before_action :login_required, only: %i(new create)
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to tasks_path
    else
      redirect_to new_session_path, notice: "ログインに失敗しました"
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path, notice: "ログアウトしました"
  end
end
