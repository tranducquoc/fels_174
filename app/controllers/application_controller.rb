class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def login_user
    unless logged_in?
      flash[:danger] = t "not_login"
      redirect_to root_url
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def load_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "exists_user"
      redirect_to root_url
    end
  end

  def verify_admin
    redirect_to root_url unless current_user.is_admin?
  end
end
