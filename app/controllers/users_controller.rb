class UsersController < ApplicationController
  def show
    return @user if @user = User.find_by(id: params[:id])
    flash[:danger] = t "misc.user_not_exists"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = t "greeting"
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email,
      :password, :password_confirmation)
  end
end
