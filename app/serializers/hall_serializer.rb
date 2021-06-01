class HallSerializer
  include JSONAPI::Serializer
  attributes :hall, :seats

  has_many :seances
end
