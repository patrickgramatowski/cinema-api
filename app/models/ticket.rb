# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :reservation, inverse_of: :tickets

  validates :price, presence: true
  validates :seat, presence: true
  validates :ticket_type, presence: true
end
