class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates :user, presence: true
  validates :category, presence: true
  has_many :results, dependent: :destroy
  has_many :words, through: :results
  accepts_nested_attributes_for :results,
    reject_if: proc {|attributes| attributes[:answer_id].blank?}

  scope :total_learned_words, -> do
    joins(results: :answer).where("answers.is_correct = 't'").count
  end

  scope :of_category, -> category_id do
    where category_id: category_id if category_id.present?
  end
end
