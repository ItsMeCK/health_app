class NotificationSerializer < ActiveModel::Serializer
  attributes :id, 

  def attributes
  	data = super
  	template = Notification.notification_template
  	data[:title] = template.title
  	date[:description] = template.content

end
