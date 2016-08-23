class Word < ActiveRecord::Base
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :answers, dependent: :destroy
  validates :category, presence: true
  validates :content, presence: true
  validates :sound, presence: true
  accepts_nested_attributes_for :answers,
    reject_if: proc {|attributes| attributes[:content].blank?}

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

  class << self
    def to_csv options = {}
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |word|
          csv << word.attributes.values_at(*column_names)
        end
      end
    end
  end
end
