class WordsController < ApplicationController
  before_action :login_user, only: [:index, :search]

  def index
    @categories = Category.all
    params[:word_filter] ||= Settings.word_filter[:all]
    @words = Word.of_category(params[:category_id])
        .send(params[:word_filter], current_user.id)
  end
end
