class LessonsController < ApplicationController
  before_action :login_user, only: [:edit, :update]

  def edit
    @lesson = Lesson.find_by id: params[:id]
  end

  def update
    @lesson = Lesson.find_by id: params[:id]
    if @lesson.update(lesson_params)
      redirect_to results_path lesson_id: params[:id]
    else
      flash[:danger] = t "learn_lesson.finish_failed"
      render edit_category_lesson_path
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit(results_attributes: [:id, :answer_id])
  end
end
