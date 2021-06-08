# frozen_string_literal: true

class Seance < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  has_many :reservations

  validates :date, presence: true
  validates :time, presence: true
  validates :movie_id, presence: true
  validates :hall_id, presence: true
end
