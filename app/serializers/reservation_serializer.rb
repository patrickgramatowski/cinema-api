# frozen_string_literal: true

class ReservationSerializer
  include JSONAPI::Serializer
  attributes :seance, :ticket_desk, :status, :tickets, :seats

  has_many :tickets
  has_one :ticket_desk
  has_one :seance
end
