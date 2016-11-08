class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image, :imageable_id, :imageable_type
end
