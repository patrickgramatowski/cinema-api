class MovieSerializer
  include JSONAPI::Serializer
  attributes :title, :genre, :length
end
