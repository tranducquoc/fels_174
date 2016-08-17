class CategoriesController < ApplicationController
  before_action :login_user, only: [:index]

  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.record_per_page
  end

  def show
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = t "not_category"
      redirect_to root_url
    end
    @words = @category.words.random
  end
end
