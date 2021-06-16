# frozen_string_literal: true

class Seance < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  has_many :reservations

  validates :date, presence: true
  validates :time, presence: true
  validates :movie_id, presence: true
  validates :hall_id, presence: true

  def time_before_seance
    date - 30.minutes
  end

  def after_confirmation_time?
    Time.current.after?(time_before_seance)
  end
end
