class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      login_redirect user
    else
      flash.now[:danger] = t "misc.invalid_email_password"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def login_redirect user
    log_in user
    if params[:session][:remember_me] == Settings.check_success
      remember(user)
    else
      forget(user)
    end
    redirect_to user
  end
end
