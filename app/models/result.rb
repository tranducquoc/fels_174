class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :answer
  validates :lesson, presence: true
  validates :word, presence: true

  scope :of_lesson, -> lesson_id do
    where(lesson_id: lesson_id)
  end

  scope :of_user, -> user_id do
    joins(:lesson).where(lessons: {user_id: user_id})
  end

end
