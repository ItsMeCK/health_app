class Web::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :authentication_token

  has_one :profile
end
