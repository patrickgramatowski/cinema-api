class TicketDeskSerializer
  include JSONAPI::Serializer
  attributes :online

  has_many :reservations
end
