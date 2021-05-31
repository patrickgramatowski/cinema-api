class SeanceSerializer
  include JSONAPI::Serializer
  attributes :date, :time, :movie_id, :hall_id
  has_one :hall
  has_one :movie
end
