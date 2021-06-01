class Reservation < ApplicationRecord
  belongs_to :seance

  validates :seance_id, presence: true
end
