class Movie < ApplicationRecord
  validates :title, presence: true
  validates :genre, presence: true
  validates :length, presence: true
end
