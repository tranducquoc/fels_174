class UsersController < ApplicationController
  before_action :login_user, only: [:index, :edit, :update, :destroy]
  before_action :load_user, only: [:edit, :update, :show]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.record_per_page
  end

  def show
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
      log_in @user
      flash[:success] = I18n.t "signup"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = I18n.t "update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
