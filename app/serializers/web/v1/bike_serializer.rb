class Web::V1::BikeSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :tagline, :description

  has_many :specifications, serializer: Web::V1::SpecificationSerializer


end