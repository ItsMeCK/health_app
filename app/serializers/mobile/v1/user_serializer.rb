class Mobile::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :authentication_token, :role

  has_one :profile

  def attributes
  	data = super
  	data[:notification_count] = NotificationCount.find_by_user_id(data[:id]).try(:count) || 0
  	data
  end
end
