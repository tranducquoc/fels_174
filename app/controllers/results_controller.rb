class ResultsController < ApplicationController
  before_action :login_user, only: [:index]
  before_action :create_activity, only: [:index]
  def index
    @results = Result.of_lesson params[:lesson_id]
    @lesson = Lesson.find_by id: params[:lesson_id]
  end

  private
  def create_activity
    current_user.activities.create(action_type: Activity.action_types[:learned],
      target_id: params[:lesson_id])
  end
end
