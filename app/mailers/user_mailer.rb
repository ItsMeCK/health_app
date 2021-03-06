class UserMailer < ApplicationMailer
	layout false
	default from: "app@coromandel-harley.in"

	@@dealer = Dealer.all
	@@setmail = SetMail.all

	def password_reset(user)
		@user = user
		mail :to => user.email, :subject => "Password Reset link for Coramandal Harley David Son Mobile App"
	end

	def password_reset_success(user)
		@n_template = SetNotificationTemplate.find_by_category("Password reset success mail-user")
		@password_reset_confirm_user = @n_template.template % {Welcome_Customer_Name:user.name, Welcome_Customer_Email:user.email, Welcome_Customer_Number:user.mobile }
		@subject = @n_template.title % { Welcome_Customer_Name:user.name, Welcome_Customer_Email:user.email, Welcome_Customer_Number:user.mobile }
		mail :to => user.email, :subject => @subject, :body => @password_reset_confirm_user
	end

	def test_ride_booking(testride, notification_type)
		@vehicle_model = testride.bike
		@showroom = @@dealer.find_by_dealer_name(I18n.t('Dealer.name'))
		@mail_list = @@setmail.find_by_category("Test drive booking")
		@pickup_request = testride.request_pick_up
		if @pickup_request == true
			@pickup_req = "Yes"
			@address = testride.address
		else
			@pickup_req = "No"
		end
		#key words
		# fuel_type:testride.fuel_type, TestDriveBooking_Showroom_Number:@showroom.mobile,
		@coramandal_template = EmailNotificationTemplate.find_by_category(notification_type)
		@testride_confirm_dealer = @coramandal_template.content % { TestDriveBooking_Customer_Name:testride.try(:name), TestDriveBooking_Car_Model:@vehicle_model, TestDriveBooking_Date:testride.ride_date.strftime("%d/%m/%Y"), TestDriveBooking_Time:testride.ride_time.strftime("%I:%M%p"), TestDriveBooking_Showroom_Address:@showroom.try(:address),  TestDriveBooking_Showroom_Name:@showroom.try(:dealer_name), TestDriveBooking_Customer_Number:testride.try(:mobile), TestDriveBooking_Customer_Email:testride.try(:email), TestDriveBooking_Customer_Address:testride.try(:address), TestDriveBooking_PickUp_Request:@pickup_req, TestDriveBook_PickUp_Address:@pickup_req, TestDriveBooking_Day:testride.ride_date.strftime("%d").to_i.ordinalize, TestDriveBooking_Month:testride.ride_date.strftime("%B"), TestDriveBooking_Year:testride.ride_date.strftime("%Y"), TestDriveBooking_Weekday:testride.ride_date.strftime("%A") }
		@subject = @coramandal_template.title % { TestDriveBooking_Customer_Name:testride.try(:name), TestDriveBooking_Car_Model:@vehicle_model, TestDriveBooking_Date:testride.ride_date.strftime("%d/%m/%Y"), TestDriveBooking_Time:testride.ride_time.strftime("%I:%M%p"), TestDriveBooking_Showroom_Address:@showroom.try(:address),  TestDriveBooking_Showroom_Name:@showroom.try(:dealer_name), TestDriveBooking_Customer_Number:testride.try(:mobile), TestDriveBooking_Customer_Email:testride.try(:email), TestDriveBooking_Customer_Address:testride.try(:address), TestDriveBooking_PickUp_Request:@pickup_req, TestDriveBook_PickUp_Address:@pickup_req, TestDriveBooking_Day:testride.ride_date.strftime("%d").to_i.ordinalize, TestDriveBooking_Month:testride.ride_date.strftime("%B"), TestDriveBooking_Year:testride.ride_date.strftime("%Y"), TestDriveBooking_Weekday:testride.ride_date.strftime("%A") }

		mail :to => @mail_list.email, :subject => @subject
	end

	def testride_request_confirm(testride, notification_type)
		@vehicle_model = testride.bike
		@showroom = @@dealer.find_by_dealer_name(I18n.t('Dealer.name'))
		@pickup_request = testride.request_pick_up
		if @pickup_request == true
			@pickup_request = "Yes"
			@pickup_req = "You have selected for the vehicle to be brought home for the Test Drive <br/>
			Address:</br>
			#{testride.try(:address)}<br/>"
		else
			@pickup_req = "You have indicated that you will come to our #{testride.try(:sales_center)} showroom for the Test Drive<br/>Our #{@showroom.try(:dealer_name)} showroom is located at <br/>
			#{@showroom.try(:address)}<br/>"
			@pickup_request = "No"
		end
		@coramandal_template = EmailNotificationTemplate.find_by_category(notification_type)
		@testdrive_confirm_user = @coramandal_template.content % { TestDriveBooking_Customer_Name:testride.try(:name), TestDriveBooking_Car_Model:@vehicle_model, TestDriveBooking_Date:testride.ride_date.strftime("%d/%m/%Y"), TestDriveBooking_Time:testride.ride_time.strftime("%I:%M%p"), TestDriveBooking_Showroom_Address:@showroom.try(:address),  TestDriveBooking_Showroom_Name:@showroom.try(:dealer_name), TestDriveBooking_Customer_Number:testride.try(:mobile), TestDriveBooking_Customer_Email:testride.try(:email), TestDriveBooking_Customer_Address:testride.try(:address), TestDriveBooking_PickUp_Request:@pickup_req, TestDriveBook_PickUp_Address:@pickup_req, TestDriveBooking_Day:testride.ride_date.strftime("%d").to_i.ordinalize, TestDriveBooking_Month:testride.ride_date.strftime("%B"), TestDriveBooking_Year:testride.ride_date.strftime("%Y"), TestDriveBooking_Weekday:testride.ride_date.strftime("%A") }
		@subject = @coramandal_template.title % { TestDriveBooking_Customer_Name:testride.try(:name), TestDriveBooking_Car_Model:@vehicle_model, TestDriveBooking_Date:testride.ride_date.strftime("%d/%m/%Y"), TestDriveBooking_Time:testride.ride_time.strftime("%I:%M%p"), TestDriveBooking_Showroom_Address:@showroom.try(:address),  TestDriveBooking_Showroom_Name:@showroom.try(:dealer_name), TestDriveBooking_Customer_Number:testride.try(:mobile), TestDriveBooking_Customer_Email:testride.try(:email), TestDriveBooking_Customer_Address:testride.try(:address), TestDriveBooking_PickUp_Request:@pickup_req, TestDriveBook_PickUp_Address:@pickup_req, TestDriveBooking_Day:testride.ride_date.strftime("%d").to_i.ordinalize, TestDriveBooking_Month:testride.ride_date.strftime("%B"), TestDriveBooking_Year:testride.ride_date.strftime("%Y"), TestDriveBooking_Weekday:testride.ride_date.strftime("%A") }

		cal = Icalendar::Calendar.new
		cal.event do |e|
 		 	e.dtstart = Icalendar::Values::DateTime.new testride.ride_time
			e.dtend   = Icalendar::Values::DateTime.new testride.ride_time + 1.hour
  		e.summary     = "Coramandal Harley David Son"
  		e.description = "Test drive booking request with Coromandel Harley Davidson"
  		e.ip_class    = "PRIVATE"
  		e.alarm do |a|
  			a.action        = "AUDIO"
  			a.trigger       = "-PT60M"
  			a.append_attach "Test drive booking request with Coromandel Harley Davidson"
			end
		end
		attachments['event.ics'] = cal.to_ical

		mail :to => testride.email, :subject => @subject
	end

  #admin service booking mail
  def service_booking(service, booking_type)
  	logger.info "=======Dealer Service Booking Email Notification========"
  	@vehicle_model = service.my_bike.bike
  	@pickup_request = service.request_pick_up
  	if @pickup_request == true
  		@pickup_req = "Yes"
  	else
  		@pickup_req = "No"
  	end
  	@service_center = @@dealer.find_by_dealer_name(service.service_station)
  	@mail_list = @@setmail.find_by_category("Service booking")
		#ServiceBooking_Customer_Address, ServiceBooking_Customer_number
		@n_template = EmailNotificationTemplate.find_by_category(booking_type)
		@service_confirm_dealer = @n_template.content % { ServiceBooking_Customer_Name:service.my_bike.user.profile.full_name, ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Customer_Address: "fsff sdfsdfsdf",  ServiceBooking_Customer_Number: "4534534534",  ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y"), ServiceBooking_Time:service.service_time.strftime("%I:%M%p"), ServiceBooking_Car_RegistrationNumber:service.try(:registration_number), ServiceBooking_PickUp_Request:@pickup_req, ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name), ServiceBooking_ServiceCenter_Number:@service_center.try(:mobile),  ServiceBooking_PickUp_Address:@pickup_req,  ServiceBooking_Car_KmsRun:service.try(:kms), ServiceBooking_ServiceCenter_Address:@service_center.try(:address), ServiceBooking_Service_Type:service.try(:service_type), vehicle_kms:service.try(:kms), ServiceBooking_Customer_Comments:service.try(:comments), ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Month:service.service_date.strftime("%B"), ServiceBooking_Yea:service.service_date.strftime("%Y"), ServiceBooking_Weekday:service.service_date.strftime("%A") }
		@subject = @n_template.title % { ServiceBooking_Customer_Name:service.my_bike.user.profile.full_name, ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Car_Model:@vehicle_model }

		mail :to => @mail_list.email, :subject => @subject
	end

#mail for user service booking confirmation
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
    @service_confirm_user = @n_template.content % { ServiceBooking_Customer_Name:service.my_bike.user.profile.full_name, ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Customer_Address: "sdfsdfdsfs dsfsd", ServiceBooking_Customer_Number: "56456456", ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y"), ServiceBooking_Time:service.service_time.strftime("%I:%M%p"), ServiceBooking_Car_RegistrationNumber:service.try(:registration_number), ServiceBooking_PickUp_Request:@pickup_req, ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name), ServiceBooking_ServiceCenter_Number:@service_center.try(:mobile),  ServiceBooking_PickUp_Address:@pickup_req,  ServiceBooking_Car_KmsRun:service.try(:kms), ServiceBooking_ServiceCenter_Address:@service_center.try(:address), ServiceBooking_Service_Type:service.try(:service_type), vehicle_kms:service.try(:kms), ServiceBooking_Customer_Comments:service.try(:comments), ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Month:service.service_date.strftime("%B"), ServiceBooking_Year:service.service_date.strftime("%Y"), ServiceBooking_Weekday:service.service_date.strftime("%A") }  

    @subject = @n_template.title % { ServiceBooking_Customer_Name:service.try(:name), ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name) } 
    
		cal = Icalendar::Calendar.new
		cal.event do |e|
 		 	e.dtstart = Icalendar::Values::DateTime.new service.service_time
			e.dtend   = Icalendar::Values::DateTime.new service.service_time + 1.hour
  		e.summary     = "Coramandal Harley David Son"
  		e.description = "Service booking request with Coromandel Harley Davidson"
  		e.ip_class    = "PRIVATE"
  		e.alarm do |a|
  			a.action        = "AUDIO"
  			a.trigger       = "-PT60M"
  			a.append_attach "Service booking request with Coromandel Harley Davidson"
			end
		end
		attachments['event.ics'] = cal.to_ical
			
    mail :to => service.my_bike.user.email, :subject => @subject
end

def insurance_renewal(insurance)
	@vehicle_model = insurance.bike
	@insurance_renewal = insurance
	@mail_list = @@setmail.find_by_category("Insurance renewal")
	#InsuranceRenewal_Car_ManufactureYear
	ex_date = Date.parse(insurance.expiry_date)

	@n_template = EmailNotificationTemplate.find_by_category("Insurance renewal mail-dealer")
	@insurance_request_dealer = @n_template.content % { InsuranceRenewal_Kms:insurance.kms, InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:insurance.bike, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:ex_date.strftime("%d").to_i.ordinalize, month:ex_date.strftime("%B"), year:ex_date.strftime("%Y"), weekday:ex_date.strftime("%A"), vehicle_kms:insurance.kms }
	@subject = @n_template.title  % { InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:insurance.bike, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:ex_date.strftime("%d").to_i.ordinalize, month:ex_date.strftime("%B"), year:ex_date.strftime("%Y"), weekday:ex_date.strftime("%A"), vehicle_kms:insurance.kms }
	mail :to => @mail_list.email, :subject => @subject
end

def insurance_renewal_confirm(insurance)
	@vehicle_model = insurance.bike
	@n_template = EmailNotificationTemplate.find_by_category("Insurance renewal mail-user")
	ex_date = Date.parse(insurance.expiry_date)


	@insurance_request_user = @n_template.content % { InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:insurance.bike, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:ex_date.strftime("%d").to_i.ordinalize, month:ex_date.strftime("%B"), year:ex_date.strftime("%Y"), weekday:ex_date.strftime("%A"), vehicle_kms:insurance.kms }
	@subject = @n_template.title  % { InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:insurance.bike, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:ex_date.strftime("%d").to_i.ordinalize, month:ex_date.strftime("%B"), year:ex_date.strftime("%Y"), weekday:ex_date.strftime("%A"), vehicle_kms:insurance.kms }
	mail :to => insurance.email, :subject => @subject
end

def used_vehicle_enquiry_confirm(used_vehicle_enquiry)
	@n_template = EmailNotificationTemplate.find_by_category("Used vehicle enquiry mail-user")
	@enquiry_confirm_user = @n_template.template % { ContactUs_Customer_Name:used_vehicle_enquiry.email, ContactUs_Customer_Email:used_vehicle_enquiry.name, ContactUs_Customer_Address:used_vehicle_enquiry.address, ContactUs_Customer_Number:used_vehicle_enquiry.phone, ContactUs_Dealerership_Name:used_vehicle_enquiry.dealer_location, ContactUs_AreaOfEnquiry:used_vehicle_enquiry.area_of_enquiry, vehicle:used_vehicle_enquiry.vehicle_model, vehicle_year:used_vehicle_enquiry.vehicle_year, vehicle_price:used_vehicle_enquiry.price, content:used_vehicle_enquiry.comment, ContactUs_Comment:used_vehicle_enquiry.comment, ContactUs_Car_Kms:used_vehicle_enquiry.kms, registration_number:used_vehicle_enquiry.registration_number, dealer_number:used_vehicle_enquiry.dealer_number }
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

def notification_mail_for_ride(user, ride, email_template)
	template = EmailNotificationTemplate.find_by_category(email_template)
	@ride_content = template.content % {Ride_Customer_Name: user.try(:profile).try(:full_name), Ride_Final_Destination: ride.destination_location, Ride_date: ride.ride_date}
	ride_title = template.title % {Ride_date: ride.ride_date}

	mail :to => user.email, :subject => ride_title
end

def notification_mail_for_event(user, event, email_template)
	template = EmailNotificationTemplate.find_by_category(email_template)
	@event_content = template.content % {Event_Customer_Name: user.try(:profile).try(:full_name), Event_Final_Destination: event.location, Event_date: event.event_date}
	event_title = template.title % {Event_date: event.event_date}

	mail :to => user.email, :subject => event_title
end

def feedback(feedback)
	@feedback = feedback
	@mail_list = @@setmail.find_by_category("Feedback")
	@n_template = EmailNotificationTemplate.find_by_category("Feedback mail-dealer")
	@feedback_confirm_dealer = @n_template.content % { Feedback_Customer_Name:feedback.name, Feedback_Customer_Number:feedback.mobile, Feedback_Customer_Email:feedback.email, Feedback_Title:feedback.feedback_type, Feedback_Description:feedback.comment  }
	@subject = @n_template.title % { Feedback_Customer_Name:feedback.name, Feedback_Customer_Number:feedback.mobile, Feedback_Customer_Email:feedback.email, Feedback_Title:feedback.feedback_type, Feedback_Description:feedback.comment }
	mail :to => @mail_list.email, :subject => @subject
end

def contact_us(enquiry)
	@mail_list = @@setmail.find_by_category("Enquiry")
	@showroom = @@dealer.find_by_dealer_name(I18n.t('Dealer.name'))

	@n_template = EmailNotificationTemplate.find_by_category("Contact us mail-dealer")
	@enq_content = @n_template.content % {ContactUs_Customer_Name: enquiry.name, ContactUs_Customer_Number: enquiry.phone, ContactUs_Customer_Email: enquiry.email, ContactUs_Dealerership_Name: @showroom.try(:name), ContactUs_AreaOfEnquiry: enquiry.category, ContactUs_Comment: enquiry.message}
	enq_title = @n_template.title % {ContactUs_AreaOfEnquiry: enquiry.category}
	mail :to => @mail_list.email, :subject => enq_title
end	

def welcome_user(user)
	@n_template = EmailNotificationTemplate.find_by_category("Welcome mail-user")
	@content = @n_template.content % {Welcome_Customer_Name:user.profile.full_name, Welcome_Customer_Email:user.email}
	title = @n_template.title
	mail :to => user.email, :subject => title
end

def send_finance_document(email, family)
	doc = FinanceDocument.where('category = ? and family = ? ', 'Email Template', family).first
	subject = "#{family.capitalize} Document For Coromandel Harley-Davidson"
	@document = doc.document_list
	mail :to => email, :subject => subject
end	

end
