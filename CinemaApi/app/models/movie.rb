class Movie < ApplicationRecord
  belongs_to :director
  validates :title, presence: true
  validates :sinopsis, presence: true
  validates :duration, presence: true
  validates :premiere, presence: true
  validates :director, presence:true
end
