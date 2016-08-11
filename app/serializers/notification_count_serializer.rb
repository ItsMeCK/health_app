class NotificationCountSerializer < ActiveModel::Serializer
  attributes :id
  def attributes
  	data = super
  	data[:Offer] = data[:offer]
  	data[:Bookings] = data[:bookings]
  	data[:Events] = data[:events]
  	data[:Accessories] = data[:accessories]
  	data
end
