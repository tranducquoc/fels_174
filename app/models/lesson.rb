class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates :user, presence: true
  validates :category, presence: true
  has_many :results, dependent: :destroy
  has_many :words, through: :results
end
