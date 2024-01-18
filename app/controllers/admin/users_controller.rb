class Admin::UsersController < ApplicationController
  before_action :require_admin
  def new
    @user = User.new(flash[:user])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      redirect_back fallback_location: @user, flash: {
        user: @user,
        error_messages: @user.errors.full_messages
      }
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redire_to admin_user_path(@user), notice: "ユーザ「#{user.name}」を登録しました。"
    else
      redirect_back fallback_location: @user, flash: {
        user: @user,
        error_messages: @user.errors.full_messages
      }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_user_path, status: :see_other, notice: "ユーザ「#{@user.name}」を削除しました。"
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_comfirmation)
  end

  def require_admin
    redirect_to root_url unless current_user.admin?
  end

end
