# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :seance
  belongs_to :ticket_desk
  belongs_to :user

  has_many :tickets

  validates :seance_id, presence: true
  validates :status, presence: true

  def expired?
    status == "pending" && seance.after_confirmation_time?
  end
end
