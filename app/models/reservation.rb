class Reservation < ApplicationRecord
  belongs_to :seance
  belongs_to :ticket_desk

  validates :seance_id, presence: true
  validates :ticket_desk_id, presence: true
  validates :status, presence: true
end
