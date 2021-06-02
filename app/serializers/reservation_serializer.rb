class ReservationSerializer
  include JSONAPI::Serializer
  attributes :seance, :ticket_desk, :status

  has_one :ticket_desk
  has_one :seance
end
