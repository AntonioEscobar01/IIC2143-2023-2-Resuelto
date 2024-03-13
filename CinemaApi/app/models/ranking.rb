class Ranking < ApplicationRecord
  belongs_to :director
  validates :page, presence: true
  validates :min_score, presence: true
  validates :score, presence: true
  validates :max_score, presence: true
  validates :director, presence: true
end
