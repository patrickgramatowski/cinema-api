class Movie < ApplicationRecord
  has_many :seances

  validates :title, presence: true
  validates :genre, presence: true
  validates :length, presence: true
end
