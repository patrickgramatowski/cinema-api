class SeanceSerializer
  include JSONAPI::Serializer
  attributes :date, :time, :hall, :movie

  belongs_to :hall
  belongs_to :movie

  has_one :hall
  has_one :movie

  has_many :reservations
end
