class TicketSerializer
  include JSONAPI::Serializer
  attributes :price, :seat, :ticket_type

  belongs_to :reservation
end
