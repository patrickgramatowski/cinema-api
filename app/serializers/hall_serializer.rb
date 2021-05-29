class CinemaHallSerializer
  include JSONAPI::Serializer
  attributes :hall, :seats
end
