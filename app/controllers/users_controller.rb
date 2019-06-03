class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(create new)
  before_action :load_user, except: %i(index create new)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def index
    @users = User.paginate page: params[:page], per_page: Settings.PER_PAGE
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "greeting"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    flash[:success] = @user.destroy ? t("user_deleted") : t("delete_failed")
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email,
      :password, :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "please_login"
    redirect_to login_path
  end

  def load_user
    return @user if @user = User.find_by(id: params[:id])
    flash[:danger] = t "misc.user_not_exists"
    redirect_to root_path
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
