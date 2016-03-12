class MovieSerializer < ActiveModel::Serializer
  attributes :id, :imdb_id, :title
end
