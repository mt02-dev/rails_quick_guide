class SessionsController < ApplicationController
  # どのURLにアクセスしてもログインが必要となりリダイレクトされるのを防ぐため
  skip_before_action :login_required
  def new
  end

  def create
    user = User.new(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      session[:id] = user.id
      redirect_to root_url, notice: 'ログインしました。'
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました。'
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
  
end
