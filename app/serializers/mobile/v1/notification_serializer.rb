class Mobile::V1::NotificationSerializer < ActiveModel::Serializer
  attributes :id, :action, :status, :created_at

  def attributes
  	data = super
  	notification = Notification.find(data[:id])
  	template = notification.notification_template
    content, title  = template.fill_keywords(notification.notifiable)
  	data[:title] = title || "N/A" 
  	data[:description] = content || "N/A"
    data
  end  
end
