class Word < ActiveRecord::Base
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :answers, dependent: :destroy
  validates :category, presence: true
  scope :not_in_ids, -> ids {where.not id: ids}

  scope :of_category, -> category_id do
    where category_id: category_id if category_id.present?
  end

  scope :show_all, -> user_id {}

  scope :learned, -> user_id do
    joins(results: [:lesson, :answer]).where(lessons: {user_id: user_id},
      answers: {is_correct: true})
  end

  scope :not_learned, -> user_id do
    not_in_ids(Word.learned user_id)
  end

  scope :random, ->{order("RANDOM()").limit(4)}
end
