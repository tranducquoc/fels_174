class Admin::UsersController < ApplicationController
  before_action :login_user, only: :show
  before_action :load_user, only: [:show, :destroy]
  before_action :verify_admin, only: [:index, :show, :destroy]

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.record_per_page
  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:success] = t "dmin.index_delete.success_delete"
    else
      flash[:danger] = t "dmin.index_delete.fail_delete"
    end
    redirect_to admin_users_url
  end
end
