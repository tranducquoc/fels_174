class Word < ActiveRecord::Base
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :answers, dependent: :destroy
  validates :category, presence: true

  scope :random, ->{order("RANDOM()").limit(4)}
end
