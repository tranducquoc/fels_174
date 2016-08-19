class RelationshipsController < ApplicationController
  before_action :login_user, only: [:create, :show, :destroy]
  before_action :load_user, only: :show

  def create
    @user = User.find_by id: params[:followed_id]
    if @user.nil?
      flash[:danger] = t "follow.not_user"
      redirect_to current_user
    else
      current_user.follow @user
      respond_to do |format|
        format.json do
          render json: {
            sSucess: true,
            followed: @user.followers.count
          }
        end
      end
    end
  end

  def show
    @users = @user.send("#{params[:message]}").paginate page: params[:page]
  end

  def destroy
    @user = Relationship.find_by(followed_id: params[:id]).followed
    if @user.nil?
      flash[:danger] = t "follow.not_user"
      redirect_to current_user
    else
      current_user.unfollow @user
      respond_to do |format|
        format.json do
          render json: {
            sSucess: true,
            followed: @user.followers.count
          }
        end
      end
    end
  end
end
