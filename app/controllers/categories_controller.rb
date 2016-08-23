class CategoriesController < ApplicationController
  before_action :login_user, only: [:index]

  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.record_per_page
  end
end
