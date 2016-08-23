class Admin::CategoriesController < ApplicationController
  before_action :login_user, only: :index
  before_action :verify_admin, only: [:index, :new, :edit, :update, :destroy]
  before_action :load_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.record_per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "admin.category.create_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "admin.category.update_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "admin.category.update_fail"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "admin.category.delete_success"
    else
      flash[:danger] = t "admin.category.delete_fail"
    end
    redirect_to admin_categories_url
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = t "admin.category.exists_category"
      redirect_to root_url
    end
  end
end
