class Mobile::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :authentication_token, :role

  has_one :profile
end
