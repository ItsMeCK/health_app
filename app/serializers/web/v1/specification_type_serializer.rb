class Web::V1::SpecificationTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :display_order, :active, :created_at, :updated_at
end
