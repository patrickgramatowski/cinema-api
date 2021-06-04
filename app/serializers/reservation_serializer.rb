class ReservationSerializer
  include JSONAPI::Serializer
  attributes :seance, :ticket_desk, :status, :tickets

  has_many :tickets
  has_one :ticket_desk
  has_one :seance
end
