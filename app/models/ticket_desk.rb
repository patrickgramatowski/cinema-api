# frozen_string_literal: true

class TicketDesk < ApplicationRecord
  validates :online, presence: true

  has_many :reservations
end
