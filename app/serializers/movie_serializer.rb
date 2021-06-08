# frozen_string_literal: true

class MovieSerializer
  include JSONAPI::Serializer
  attributes :title, :genre, :length, :seances

  has_many :seances
end
