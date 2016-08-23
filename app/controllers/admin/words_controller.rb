class Admin::WordsController < ApplicationController
  before_action :login_user
  before_action :verify_admin

  def index
    @words = Word.of_category params[:category_id]
    @category = Category.find_by params[:category_id]
  end

  def new
    @category = Category.find_by params[:category_id]
    @word = @category.words.build
    build_answers
  end

  def create
    @category = Category.find_by params[:category_id]
    @word = @category.words.new word_params
    if @word.save
      redirect_to admin_category_words_path
    else
      build_answers
      render :new
    end
  end

  def destroy

  end

  private
  def build_answers
    4.times{@word.answers.build}
  end

  def word_params
    params.require(:word).permit(:content, :sound,
      answers_attributes: [:content, :is_correct])
  end
end

