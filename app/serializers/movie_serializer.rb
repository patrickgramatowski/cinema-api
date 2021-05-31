class MovieSerializer
  include JSONAPI::Serializer
  attributes :title, :genre, :length, :seances
end
