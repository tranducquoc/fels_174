class Admin::CategoriesController < ApplicationController
  before_action :verify_admin, only: :index

  def index
    @categories = Category.all
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
