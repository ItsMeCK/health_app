class Mobile::V1::BikeSerializer < ActiveModel::Serializer
  has_one :specification
  attributes :id, :name, :tagline, :description

  

end
