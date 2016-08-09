class UsersController < ApplicationController
  def show
    @user = User.find_by params[:id]
    if @user.nil?
      flash[:danger] = I18n.t "not_success"
      redirect_to root
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = I18n.t "signup"
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
