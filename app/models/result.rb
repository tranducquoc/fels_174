class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :answer
  validates :lesson, presence: true
  validates :word, presence: true
  validates :answer, presence: true
end
