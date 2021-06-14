# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :seance
  belongs_to :ticket_desk

  has_many :tickets, inverse_of: :reservation

  accepts_nested_attributes_for :tickets, allow_destroy: true

  validates :seance_id, presence: true
  validates :seats, presence: true
  validates :ticket_desk_id, presence: true
  validates :status, presence: true, inclusion: {in: %w(confirmed pending canceled) }
end
