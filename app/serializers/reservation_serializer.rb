class ReservationSerializer
  include JSONAPI::Serializer
  attributes :seance

  has_one :seance
end
