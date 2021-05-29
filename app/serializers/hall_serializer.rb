class HallSerializer
  include JSONAPI::Serializer
  attributes :hall, :seats
end
