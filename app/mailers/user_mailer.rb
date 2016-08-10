class UserMailer < ApplicationMailer
	layout false
	default from: "admin@myridz.com"

	@@dealer = Dealer.all
	@@setmail = SetMail.all


	def password_reset(user)
		@user = user
		mail :to => user.email, :subject => "Password Reset link for Coramandal Harley David Son Mobile App"
	end

	def password_reset_success(user)
		@n_template = SetNotificationTemplate.find_by_category("Password reset success mail-user")
		@password_reset_confirm_user = @n_template.template % {customer_name:user.name, customer_email:user.email, customer_number:user.mobile }
		@subject = @n_template.title % {customer_name:user.name, customer_email:user.email, customer_number:user.mobile }
		mail :to => user.email, :subject => @subject
	end

	def test_ride_booking(testride, notification_type)
		@vehicle_model = testride.bike
		@showroom = @@dealer.find_by_dealer_name("harley davison")
		@mail_list = @@setmail.find_by_category("Test Ride booking")
		@pickup_request = testride.request_pick_up
		if @pickup_request == true
			@pickup_req = "Yes"
			@address = testride.address
		else
			@pickup_req = "No"
		end
		#key words
		# fuel_type:testride.fuel_type, showroom_number:@showroom.mobile,
		@coramandal_template = EmailNotificationTemplate.find_by_category(notification_type)
		@testride_confirm_dealer = @coramandal_template.content % { customer_name:testride.try(:name), vehicle:@vehicle_model, date:testride.ride_date.strftime("%d/%m/%Y"), time:testride.ride_time.strftime("%I:%M%p"), showroom_address:@showroom.try(:address),  showroom_name:@showroom.dealer_name, customer_number:testride.try(:mobile), customer_email:testride.try(:email), customer_address:testride.try(:address), request_pick_up:@pickup_req, pick_up_with_address:@pickup_req, day:testride.ride_date.strftime("%d").to_i.ordinalize, month:testride.ride_date.strftime("%B"), year:testride.ride_date.strftime("%Y"), weekday:testride.ride_date.strftime("%A") }
		@subject = @coramandal_template.title % {customer_name:testride.try(:name), vehicle:@vehicle_model, date:testride.ride_date.strftime("%d/%m/%Y"), time:testride.ride_time.strftime("%I:%M%p"), showroom_address:@showroom.try(:address),  showroom_name:@showroom.dealer_name, customer_number:testride.try(:mobile), customer_email:testride.try(:email), customer_address:testride.try(:address), request_pick_up:@pickup_req, pick_up_with_address:@pickup_req, day:testride.ride_date.strftime("%d").to_i.ordinalize, month:testride.ride_date.strftime("%B"), year:testride.ride_date.strftime("%Y"), weekday:testride.ride_date.strftime("%A")}

		mail :to => @mail_list.email, :subject => @subject #:body => @testride_confirm_dealer
	end

	def testride_request_confirm(testride, notification_type)
		@vehicle_model = testride.bike
		@showroom = @@dealer.find_by_dealer_name("harley davison")
		@pickup_request = testride.request_pick_up
		if @pickup_request == true
			@pickup_request = "Yes"
			@pickup_req = "You have selected for the vehicle to be brought home for the Test Drive <br/>
			Address:</br>
			#{testride.try(:address)}<br/>"
		else
			@pickup_req = "You have indicated that you will come to our #{testdrive.try(:sales_center)} showroom for the Test Drive<br/>Our #{@showroom.try(:dealer_name)} showroom is located at <br/>
			#{@showroom.try(:address)}<br/>"
			@pickup_request = "No"
		end
		@coramandal_template = EmailNotificationTemplate.find_by_category(notification_type)
		@testdrive_confirm_user = @coramandal_template.content % { user_name:testride.try(:name), user_email:testride.email, vehicle:@vehicle_model, date:testride.ride_date.strftime("%d/%m/%Y"), time:testride.ride_time.strftime("%I:%M%p"), showroom_address:@showroom.try(:address),  showroom_name:@showroom.dealer_name, customer_number:testride.try(:mobile), customer_email:testride.try(:email), customer_address:testride.try(:address), request_pick_up:@pickup_req, pick_up_with_address:@pickup_req, day:testride.ride_date.strftime("%d").to_i.ordinalize, month:testride.ride_date.strftime("%B"), year:testride.ride_date.strftime("%Y"), weekday:testride.ride_date.strftime("%A") }
		@subject = @coramandal_template.title % { customer_name:testride.try(:name), user_name:testride.user.email, vehicle:@vehicle_model, date:testride.ride_date.strftime("%d/%m/%Y"), time:testride.ride_time.strftime("%I:%M%p"), showroom_address:@showroom.try(:address),  showroom_name:@showroom.dealer_name, customer_number:testride.try(:mobile), customer_email:testride.try(:email), customer_address:testride.try(:address), request_pick_up:@pickup_req, pick_up_with_address:@pickup_req, day:testride.ride_date.strftime("%d").to_i.ordinalize, month:testride.ride_date.strftime("%B"), year:testride.ride_date.strftime("%Y"), weekday:testride.ride_date.strftime("%A") }

		mail :to => testride.email, :subject => @subject
	end

	def service_booking(service, booking_type)
		@vehicle_model = service.model
		@pickup_request = service.request_pick_up
		if @pickup_request == true
			@pickup_req = "Yes"
		else
			@pickup_req = "No"
		end
		@service_center = @@dealer.find_by_dealer_name(service.service_station)
		@mail_list = @@setmail.find_by_category("Service booking")
		@n_template = EmailNotificationTemplate.find_by_category(booking_type)
		@service_confirm_dealer = @n_template.template % { customer_name:service.try(:name), customer_email:service.user.email, vehicle:@vehicle_model, date:service.service_date.strftime("%d/%m/%Y"), time:service.service_time.strftime("%I:%M%p"), registration_number:service.try(:registration_number), request_pick_up:@pickup_req, servicecenter_name:@service_center.try(:dealer_name), servicecenter_number:@service_center.try(:mobile),  pick_up_with_address:@pickup_req,  kms:service.try(:kms), servicecenter_address:@service_center.try(:address), service_type:service.try(:service_type), vehicle_kms:service.try(:kms), customer_comments:service.try(:comments), day:service.service_date.strftime("%d").to_i.ordinalize, month:service.service_date.strftime("%B"), year:service.service_date.strftime("%Y"), weekday:service.service_date.strftime("%A") }
		@subject = @n_template.title % { customer_name:service.try(:name), customer_email:service.user.email, vehicle:@vehicle_model, date:service.service_date.strftime("%d/%m/%Y"), time:service.service_time.strftime("%I:%M%p"), registration_number:service.try(:registration_number), request_pick_up:@pickup_req, servicecenter_name:@service_center.try(:dealer_name), servicecenter_number:@service_center.try(:mobile),  pick_up_with_address:@pickup_req,  kms:service.try(:kms), servicecenter_address:@service_center.try(:address), service_type:service.try(:service_type), vehicle_kms:service.try(:kms), customer_comments:service.try(:comments), day:service.service_date.strftime("%d").to_i.ordinalize, month:service.service_date.strftime("%B"), year:service.service_date.strftime("%Y"), weekday:service.service_date.strftime("%A") }
		mail :to => @mail_list.email, :subject => @subject
	end

	def service_request_confirm(service, booking_type)
		@vehicle_model = service.my_bike.bike
		@service_center = @@dealer.find_by_dealer_name(service.service_station)
		@pickup_request = service.request_pick_up
		if @pickup_request == true
			@pickup_req = "You have selected for the vehicle to be picked up for the Service Booking at the time specified above.<br/>Address:<br/>#{@service_center.try(:address)}</br>"
		else
			@pickup_req = "You have indicated that you will bring the vehicle to our #{@service_center.try(:dealer_name)} showroom for the Service booking.<br/>
			Our #{@service_center.try(:dealer_name)} service center is located at<br/>#{@service_center.try(:address)}<br/>"
		end
    #keywords for service booking
    #customer_number:service.try(:mobile), customer_address:service.try(:address),
    @n_template = EmailNotificationTemplate.find_by_category(booking_type)
    @service_confirm_user = @n_template.template % { customer_name:service.try(:name), customer_email:service.user.email, vehicle:@vehicle_model, date:service.service_date.strftime("%d/%m/%Y"), time:service.service_time.strftime("%I:%M%p"), registration_number:service.try(:registration_number), request_pick_up:@pickup_req, servicecenter_name:@service_center.try(:dealer_name), servicecenter_number:@service_center.try(:mobile),  pick_up_with_address:@pickup_req,  kms:service.try(:kms), servicecenter_address:@service_center.try(:address), service_type:service.try(:service_type), vehicle_kms:service.try(:kms), customer_comments:service.try(:comments), day:service.service_date.strftime("%d").to_i.ordinalize, month:service.service_date.strftime("%B"), year:service.service_date.strftime("%Y"), weekday:service.service_date.strftime("%A")}  
    @subject = @n_template.title % { customer_name:service.try(:name), customer_email:service.user.email, vehicle:@vehicle_model, date:service.service_date.strftime("%d/%m/%Y"), time:service.service_time.strftime("%I:%M%p"), registration_number:service.try(:registration_number), request_pick_up:@pickup_req, servicecenter_name:@service_center.try(:dealer_name), servicecenter_number:@service_center.try(:mobile),  pick_up_with_address:@pickup_req,  kms:service.try(:kms), servicecenter_address:@service_center.try(:address), service_type:service.try(:service_type), vehicle_kms:service.try(:kms), customer_comments:service.try(:comments), day:service.service_date.strftime("%d").to_i.ordinalize, month:service.service_date.strftime("%B"), year:service.service_date.strftime("%Y"), weekday:service.service_date.strftime("%A")} 
    mail :to => @service_request_confirm.email, :subject => @subject
end

def insurance_renewal(insurance)
	@vehicle_model = insurance.bike
	@insurance_renewal = insurance
	@mail_list = @@setmail.find_by_category("Insurance renewal")
	@n_template = EmailNotificationTemplate.find_by_category("Insurance renewal mail-dealer")
	@insurance_request_dealer = @n_template.template % {customer_name:insurance.name, vehicle:insurance.bike, registration_number:insurance.registration_number, customer_address:insurance.address, customer_number:insurance.mobile, customer_email:insurance.email, policy_number:insurance.policy_number, insurance_company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), expiry_date:insurance.expiry_date, day:insurance.expiry_date.strftime("%d").to_i.ordinalize, month:insurance.expiry_date.strftime("%B"), year:insurance.expiry_date.strftime("%Y"), weekday:insurance.expiry_date.strftime("%A"), vehicle_kms:insurance.kms }
	@subject = @n_template.title  % {customer_name:insurance.name, vehicle:insurance.bike, registration_number:insurance.registration_number, customer_address:insurance.address, customer_number:insurance.mobile, customer_email:insurance.email, policy_number:insurance.policy_number, insurance_company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), expiry_date:insurance.expiry_date, day:insurance.expiry_date.strftime("%d").to_i.ordinalize, month:insurance.expiry_date.strftime("%B"), year:insurance.expiry_date.strftime("%Y"), weekday:insurance.expiry_date.strftime("%A"), vehicle_kms:insurance.kms }
	mail :to => @mail_list.email, :subject => @subject
end

def insurance_renewal_confirm(insurance)
	@vehicle_model = insurance.model
	@n_template = EmailNotificationTemplate.find_by_category("Insurance renewal mail-user")
	@insurance_request_user = @n_template.template % {customer_name:insurance.name, vehicle:insurance.bike, registration_number:insurance.registration_number, customer_address:insurance.address, customer_number:insurance.mobile, customer_email:insurance.email, policy_number:insurance.policy_number, insurance_company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), expiry_date:insurance.expiry_date, day:insurance.expiry_date.strftime("%d").to_i.ordinalize, month:insurance.expiry_date.strftime("%B"), year:insurance.expiry_date.strftime("%Y"), weekday:insurance.expiry_date.strftime("%A"), vehicle_kms:insurance.kms }
	@subject = @n_template.title  % {customer_name:insurance.name, vehicle:insurance.bike, registration_number:insurance.registration_number, customer_address:insurance.address, customer_number:insurance.mobile, customer_email:insurance.email, policy_number:insurance.policy_number, insurance_company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), expiry_date:insurance.expiry_date, day:insurance.expiry_date.strftime("%d").to_i.ordinalize, month:insurance.expiry_date.strftime("%B"), year:insurance.expiry_date.strftime("%Y"), weekday:insurance.expiry_date.strftime("%A"), vehicle_kms:insurance.kms}
	mail :to => insurance.email, :subject => @subject
end

def used_vehicle_enquiry_confirm(used_vehicle_enquiry)
	@n_template = EmailNotificationTemplate.find_by_category("Used vehicle enquiry mail-user")
	@enquiry_confirm_user = @n_template.template % { customer_email:used_vehicle_enquiry.email, customer_name:used_vehicle_enquiry.name, customer_address:used_vehicle_enquiry.address, customer_number:used_vehicle_enquiry.phone, dealer_name:used_vehicle_enquiry.dealer_location, area_of_enquiry:used_vehicle_enquiry.area_of_enquiry, vehicle:used_vehicle_enquiry.vehicle_model, vehicle_year:used_vehicle_enquiry.vehicle_year, vehicle_price:used_vehicle_enquiry.price, content:used_vehicle_enquiry.comment, comment:used_vehicle_enquiry.comment, vehicle_kms:used_vehicle_enquiry.kms, registration_number:used_vehicle_enquiry.registration_number, dealer_number:used_vehicle_enquiry.dealer_number }
	@subject = @n_template.title % { customer_email:used_vehicle_enquiry.email, customer_name:used_vehicle_enquiry.name, customer_address:used_vehicle_enquiry.address, customer_number:used_vehicle_enquiry.mobile, dealer_name:used_vehicle_enquiry.dealer_location, area_of_enquiry:used_vehicle_enquiry.area_of_enquiry, vehicle:used_vehicle_enquiry.vehicle_model, vehicle_year:used_vehicle_enquiry.vehicle_year, vehicle_price:used_vehicle_enquiry.price, content:used_vehicle_enquiry.comment, comment:used_vehicle_enquiry.comment, vehicle_kms:used_vehicle_enquiry.kms, registration_number:used_vehicle_enquiry.registration_number, dealer_number:used_vehicle_enquiry.dealer_number }
	mail :to => used_vehicle_enquiry.email, :subject => @subject
end

def used_vehicle_enquiry(used_vehicle_enquiry)
	@mail_list = @@setmail.find_by_category("Used Vehicle Enquiry")
	@n_template = EmailNotificationTemplate.find_by_category("Used vehicle enquiry mail-dealer")
	@enquiry_confirm_dealer = @n_template.template % { customer_email:used_vehicle_enquiry.email, customer_name:used_vehicle_enquiry.name, customer_address:used_vehicle_enquiry.address, customer_number:used_vehicle_enquiry.mobile, dealer_name:used_vehicle_enquiry.dealer_location, area_of_enquiry:used_vehicle_enquiry.area_of_enquiry, vehicle:used_vehicle_enquiry.vehicle_model, vehicle_year:used_vehicle_enquiry.vehicle_year, vehicle_price:used_vehicle_enquiry.price, content:used_vehicle_enquiry.comment, comment:used_vehicle_enquiry.comment, vehicle_kms:used_vehicle_enquiry.kms, registration_number:used_vehicle_enquiry.registration_number, dealer_number:used_vehicle_enquiry.dealer_number }
	@subject = @n_template.title % { customer_email:used_vehicle_enquiry.email, customer_name:used_vehicle_enquiry.name, customer_address:used_vehicle_enquiry.address, customer_number:used_vehicle_enquiry.mobile, dealer_name:used_vehicle_enquiry.dealer_location, area_of_enquiry:used_vehicle_enquiry.area_of_enquiry, vehicle:used_vehicle_enquiry.vehicle_model, vehicle_year:used_vehicle_enquiry.vehicle_year, vehicle_price:used_vehicle_enquiry.price, comment:used_vehicle_enquiry.comment, content:used_vehicle_enquiry.comment, vehicle_kms:used_vehicle_enquiry.kms, registration_number:used_vehicle_enquiry.registration_number, dealer_number:used_vehicle_enquiry.dealer_number }
	mail :to => @mail_list.email, :subject => @subject
end




def send_notification_mail(user, notification_type)
	@notification_template = NotificationTemplate.find_by_category(notification_type)
	mail :to => user.email, :subject => @notification_template.try(:title), :body =>"this is the body"
end

def notification_mail_for_ride(user)
	mail :to => user.email, :subject => "New Ride Invitation", :body =>"this is the new ride invitation you should be perticipated on this one please accept invitation"
end

def notification_mail_for_event(user)
	mail :to => user.email, :subject => "New Event Invitation", :body =>"this is the new event invitation you should be perticipated on this one please accept invitation"
end

def feedback(feedback)
	@feedback = feedback
	@mail_list = @@setmail.find_by_category("Feedback")
	@n_template = EmailNotificationTemplate.find_by_category("Feedback mail-dealer")
	@feedback_confirm_dealer = @n_template.template % { customer_name:feedback.name, customer_number:feedback.mobile, customer_email:feedback.email, feedback_title:feedback.feedback_type, feedback_description:feedback.comment  }
	@subject = @n_template.title % { customer_name:feedback.name, customer_number:feedback.mobile, customer_email:feedback.email, feedback_title:feedback.feedback_type, feedback_description:feedback.comment }
	mail :to => @mail_list.email, :subject => @subject
end

end
