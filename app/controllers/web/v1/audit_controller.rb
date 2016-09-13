class Web::V1::AuditController < ApplicationController

	def audit_logs
	 	#for bookings
	 	service_bookings = ServiceBooking.all.collect {|service| service.audits.last if service.audits}.compact
	 	insurense_bookings = InsuranceRenewal.all.collect {|insurense| insurense.audits.last if insurense.audits}.compact
	 	test_ride_bookings = TestRide.all.collect {|test| test.audits.last if test.audits}.compact
	 	#for master data
	 	accessory = AccessoryCategory.all.collect {|accessory| accessory.audits.last if accessory.audits}.compact
	 	banner = Banner.all.collect {|banner| banner.audits.last if banner.audits}.compact
	 	contact_type = ContactType.all.collect {|contact_type| contact_type.audits.last if contact_type.audits}.compact
	 	contact = ContactNumber.all.collect {|contact| contact.audits.last if contact.audits}.compact
	 	dealer_type = DealerType.all.collect {|dealer_type| dealer_type.audits.last if dealer_type.audits}.compact
	 	default_image = DefaultBikeImage.all.collect {|default_image| default_image.audits.last if default_image.audits}.compact
	 	feature_type = KeyFeatureType.all.collect {|feature_type| feature_type.audits.last if feature_type.audits}.compact
	 	documents = FinanceDocument.all.collect {|documents| documents.audits.last if documents.audits}.compact
	 	price_field = PriceField.all.collect {|price_field| price_field.audits.last if price_field.audits}.compact
	 	set_mails = SetMail.all.collect {|set_mails| set_mails.audits.last if set_mails.audits}.compact
	 	#notification_temp = NotificationTemplate.all.collect {|notification_temp| notification_temp.audits.last if notification_temp.audits}.compact
	 	#notification = Notification.all.collect {|notification| notification.audits.last if notification.audits}.compact
	 	#email = EmailNotificationTemplate.all.collect {|email| email.audits.last if email.audits}.compact
	 	#noti_cat = NotificationCategory.all.collect {|noti_cat| noti_cat.audits.last if noti_cat.audits}.compact
	 	set_rule = SetRule.all.collect {|set_rule| set_rule.audits.last if set_rule.audits}.compact
	 	type = SpecificationType.all.collect {|type| type.audits.last if type.audits}.compact
	 	tenure = Tenure.all.collect {|tenure| tenure.audits.last if tenure.audits}.compact
	 	#for vehicle datails
	 	vehi_accessories = Accessory.all.collect {|acc| acc.audits.last if acc.audits}.compact
	 	bike = Bike.all.collect {|bike| bike.audits.last if bike.audits}.compact
	 	feature = KeyFeature.all.collect {|feature| feature.audits.last if feature.audits}.compact
	 	price = Pricing.all.collect {|price| price.audits.last if price.audits}.compact
	 	schedule = ServiceSchedule.all.collect {|schedule| schedule.audits.last if schedule.audits}.compact
	 	specification = Specification.all.collect {|specification| specification.audits.last if specification.audits}.compact
	 	color = BikeColor.all.collect {|color| color.audits.last if color.audits}.compact
	 	gallery = Gallery.all.collect {|gallery| gallery.audits.last if gallery.audits}.compact
	 	#for dealers
	 	dea_contact = DealerContactLabel.all.collect {|dea_contact| dea_contact.audits.last if dea_contact.audits}.compact
	 	deal_con_number = DealerContactNumber.all.collect {|deal_con_number| deal_con_number.audits.last if deal_con_number.audits}.compact
	 	dealer = Dealer.all.collect {|dealer| dealer.audits.last if dealer.audits}.compact

	 	bookings = service_bookings + insurense_bookings + test_ride_bookings + test_ride_bookings
	 	master_data = accessory + banner + contact_type + contact + dealer_type + default_image + feature_type + documents + price_field + set_mails + set_rule + type + tenure
	 	vehicle_details = vehi_accessories + bike + feature + price + schedule + specification + color + gallery
	 	dealer_details = dea_contact + deal_con_number + dealer

        all_details = bookings + master_data + vehicle_details + dealer_details
	 	total = all_details.collect { |f| {type:f.auditable_type, user:User.find_by_id(f.user_id).try(:email), action:f.action, changes: f.audited_changes, action_time: f.created_at} }
	 	@audit_logs = total.sort_by {|a| a[:action_time]}.reverse!
	 	render json: @audit_logs, root: "audits"
	 end


	end
