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

  def edit
    @word = Word.find_by id: params[:id]
  end

  def update
    @word = Word.find_by id: params[:id]
    if @word.update(word_params)
      flash[:success] = I18n.t "admin.words.edit.success"
      redirect_to admin_category_words_path
    else
      flash[:danger] = I18n.t "admin.words.edit.failed"
      render :edit
    end
  end

  def destroy
    @word = Word.find_by id: params[:id]
    if Result.find_by(word_id: params[:id]).nil?
      @word.destroy
      flash[:success] = I18n.t "admin.words.delete.success"
      redirect_to admin_category_words_path
    else
      flash[:danger] = I18n.t "admin.words.delete.failed"
      @category = Category.find_by params[:category_id]
      @words = @category.words
      redirect_to admin_category_words_path
    end
  end

  private
  def build_answers
    4.times{@word.answers.build}
  end

  def word_params
    params.require(:word).permit(:content, :sound,
      answers_attributes: [:id, :content, :is_correct])
  end
end

