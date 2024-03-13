class Director < ApplicationRecord
    has_many :movies, dependent: :destroy
    has_many :rankings, dependent: :destroy
    validates :name, presence: true
    validates :age, presence: true
    validates :country, presence: true
    validates :has_oscars, inclusion: { in: [true, false] }
end
