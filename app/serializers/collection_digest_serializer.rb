class CollectionDigestSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :movies_count
end
