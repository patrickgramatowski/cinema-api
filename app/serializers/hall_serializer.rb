# frozen_string_literal: true

class HallSerializer
  include JSONAPI::Serializer
  attributes :hall, :seats

  has_many :seances
end
