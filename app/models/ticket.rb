# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :reservation

  validates :price, presence: true
  validates :seat, presence: true
  validates :ticket_type, presence: true
  validates :reservation_id, presence: true
end
