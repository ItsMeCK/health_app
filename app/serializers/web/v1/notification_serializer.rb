class Web::V1::NotificationSerializer < ActiveModel::Serializer
  attributes :id

  def attributes
  	data = super
  	notification = Notification.find(data[:id])
  	template = notification.notification_template
  	data[:title] = template.try(:title)
  	data[:description] = template.try(:content)
  	data[:category] = template.try(:category)
  	names = []
  	Notification.where(parent_id: notification.id).each do |notn|
  		names << notn.recipient.profile.full_name
  	end	
  	data[:user_name] = names.empty? ? notification.try(:recipient).try(:profile).try(:full_name) : names 
    data
  end  
end
