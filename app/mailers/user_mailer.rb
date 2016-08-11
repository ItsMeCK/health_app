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
		@password_reset_confirm_user = @n_template.template % {Welcome_Customer_Name:user.name, Welcome_Customer_Email:user.email, Welcome_Customer_Number:user.mobile }
		@subject = @n_template.title % { Welcome_Customer_Name:user.name, Welcome_Customer_Email:user.email, Welcome_Customer_Number:user.mobile }
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
		# fuel_type:testride.fuel_type, TestDriveBooking_Showroom_Number:@showroom.mobile,
		@coramandal_template = EmailNotificationTemplate.find_by_category(notification_type)
		@testride_confirm_dealer = @coramandal_template.content % { TestDriveBooking_Customer_Name:testride.try(:name), TestDriveBooking_Car_Model:@vehicle_model, TestDriveBooking_Date:testride.ride_date.strftime("%d/%m/%Y"), TestDriveBooking_Time:testride.ride_time.strftime("%I:%M%p"), TestDriveBooking_Showroom_Address:@showroom.try(:address),  TestDriveBooking_Showroom_Name:@showroom.dealer_name, TestDriveBooking_Customer_Number:testride.try(:mobile), TestDriveBooking_Customer_Email:testride.try(:email), TestDriveBooking_Customer_Address:testride.try(:address), TestDriveBooking_PickUp_Request:@pickup_req, TestDriveBook_PickUp_Address:@pickup_req, TestDriveBooking_Day:testride.ride_date.strftime("%d").to_i.ordinalize, TestDriveBooking_Month:testride.ride_date.strftime("%B"), TestDriveBooking_Year:testride.ride_date.strftime("%Y"), TestDriveBooking_Weekday:testride.ride_date.strftime("%A") }
		@subject = @coramandal_template.title % { TestDriveBooking_Customer_Name:testride.try(:name), TestDriveBooking_Car_Model:@vehicle_model, TestDriveBooking_Date:testride.ride_date.strftime("%d/%m/%Y"), TestDriveBooking_Time:testride.ride_time.strftime("%I:%M%p"), TestDriveBooking_Showroom_Address:@showroom.try(:address),  TestDriveBooking_Showroom_Name:@showroom.dealer_name, TestDriveBooking_Customer_Number:testride.try(:mobile), TestDriveBooking_Customer_Email:testride.try(:email), TestDriveBooking_Customer_Address:testride.try(:address), TestDriveBooking_PickUp_Request:@pickup_req, TestDriveBook_PickUp_Address:@pickup_req, TestDriveBooking_Day:testride.ride_date.strftime("%d").to_i.ordinalize, TestDriveBooking_Month:testride.ride_date.strftime("%B"), TestDriveBooking_Year:testride.ride_date.strftime("%Y"), TestDriveBooking_Weekday:testride.ride_date.strftime("%A") }

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
		@testdrive_confirm_user = @coramandal_template.content % { TestDriveBooking_Customer_Name:testride.try(:name), TestDriveBooking_Car_Model:@vehicle_model, TestDriveBooking_Date:testride.ride_date.strftime("%d/%m/%Y"), TestDriveBooking_Time:testride.ride_time.strftime("%I:%M%p"), TestDriveBooking_Showroom_Address:@showroom.try(:address),  TestDriveBooking_Showroom_Name:@showroom.dealer_name, TestDriveBooking_Customer_Number:testride.try(:mobile), TestDriveBooking_Customer_Email:testride.try(:email), TestDriveBooking_Customer_Address:testride.try(:address), TestDriveBooking_PickUp_Request:@pickup_req, TestDriveBook_PickUp_Address:@pickup_req, TestDriveBooking_Day:testride.ride_date.strftime("%d").to_i.ordinalize, TestDriveBooking_Month:testride.ride_date.strftime("%B"), TestDriveBooking_Year:testride.ride_date.strftime("%Y"), TestDriveBooking_Weekday:testride.ride_date.strftime("%A") }
		@subject = @coramandal_template.title % { TestDriveBooking_Customer_Name:testride.try(:name), TestDriveBooking_Car_Model:@vehicle_model, TestDriveBooking_Date:testride.ride_date.strftime("%d/%m/%Y"), TestDriveBooking_Time:testride.ride_time.strftime("%I:%M%p"), TestDriveBooking_Showroom_Address:@showroom.try(:address),  TestDriveBooking_Showroom_Name:@showroom.dealer_name, TestDriveBooking_Customer_Number:testride.try(:mobile), TestDriveBooking_Customer_Email:testride.try(:email), TestDriveBooking_Customer_Address:testride.try(:address), TestDriveBooking_PickUp_Request:@pickup_req, TestDriveBook_PickUp_Address:@pickup_req, TestDriveBooking_Day:testride.ride_date.strftime("%d").to_i.ordinalize, TestDriveBooking_Month:testride.ride_date.strftime("%B"), TestDriveBooking_Year:testride.ride_date.strftime("%Y"), TestDriveBooking_Weekday:testride.ride_date.strftime("%A") }

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
		#ServiceBooking_Customer_Address, ServiceBooking_Customer_number
		@n_template = EmailNotificationTemplate.find_by_category(booking_type)
		@service_confirm_dealer = @n_template.template % { ServiceBooking_Customer_Name:service.try(:name), ServiceBooking_Customer_Email:service.user.email, ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y"), ServiceBooking_Time:service.service_time.strftime("%I:%M%p"), ServiceBooking_Car_RegistrationNumber:service.try(:registration_number), ServiceBooking_PickUp_Request:@pickup_req, ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name), ServiceBooking_ServiceCenter_Number:@service_center.try(:mobile),  ServiceBooking_PickUp_Address:@pickup_req,  ServiceBooking_Car_KmsRun:service.try(:kms), ServiceBooking_ServiceCenter_Address:@service_center.try(:address), ServiceBooking_Service_Type:service.try(:service_type), vehicle_kms:service.try(:kms), ServiceBooking_Customer_Comments:service.try(:comments), ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Month:service.service_date.strftime("%B"), ServiceBooking_Yea:service.service_date.strftime("%Y"), ServiceBooking_Weekday:service.service_date.strftime("%A") }
		@subject = @n_template.title % { ServiceBooking_Customer_Name:service.try(:name), ServiceBooking_Customer_Email:service.user.email, ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y"), ServiceBooking_Time:service.service_time.strftime("%I:%M%p"), ServiceBooking_Car_RegistrationNumber:service.try(:registration_number), ServiceBooking_PickUp_Request:@pickup_req, ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name), ServiceBooking_ServiceCenter_Number:@service_center.try(:mobile),  ServiceBooking_PickUp_Address:@pickup_req,  ServiceBooking_Car_KmsRun:service.try(:kms), ServiceBooking_ServiceCenter_Address:@service_center.try(:address), ServiceBooking_Service_Type:service.try(:service_type), vehicle_kms:service.try(:kms), ServiceBooking_Customer_Comments:service.try(:comments), ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Month:service.service_date.strftime("%B"), ServiceBooking_Yea:service.service_date.strftime("%Y"), ServiceBooking_Weekday:service.service_date.strftime("%A") }
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
    @service_confirm_user = @n_template.template % { ServiceBooking_Customer_Name:service.try(:name), ServiceBooking_Customer_Email:service.user.email, ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y"), ServiceBooking_Time:service.service_time.strftime("%I:%M%p"), ServiceBooking_Car_RegistrationNumber:service.try(:registration_number), ServiceBooking_PickUp_Request:@pickup_req, ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name), ServiceBooking_ServiceCenter_Number:@service_center.try(:mobile),  ServiceBooking_PickUp_Address:@pickup_req,  ServiceBooking_Car_KmsRun:service.try(:kms), ServiceBooking_ServiceCenter_Address:@service_center.try(:address), ServiceBooking_Service_Type:service.try(:service_type), vehicle_kms:service.try(:kms), ServiceBooking_Customer_Comments:service.try(:comments), ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Month:service.service_date.strftime("%B"), ServiceBooking_Yea:service.service_date.strftime("%Y"), ServiceBooking_Weekday:service.service_date.strftime("%A")}  
    @subject = @n_template.title % { ServiceBooking_Customer_Name:service.try(:name), ServiceBooking_Customer_Email:service.user.email, ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y"), ServiceBooking_Time:service.service_time.strftime("%I:%M%p"), ServiceBooking_Car_RegistrationNumber:service.try(:registration_number), ServiceBooking_PickUp_Request:@pickup_req, ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name), ServiceBooking_ServiceCenter_Number:@service_center.try(:mobile),  ServiceBooking_PickUp_Address:@pickup_req,  ServiceBooking_Car_KmsRun:service.try(:kms), ServiceBooking_ServiceCenter_Address:@service_center.try(:address), ServiceBooking_Service_Type:service.try(:service_type), vehicle_kms:service.try(:kms), ServiceBooking_Customer_Comments:service.try(:comments), ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Month:service.service_date.strftime("%B"), ServiceBooking_Yea:service.service_date.strftime("%Y"), ServiceBooking_Weekday:service.service_date.strftime("%A") } 
    mail :to => @service_request_confirm.email, :subject => @subject
end

def insurance_renewal(insurance)
	@vehicle_model = insurance.bike
	@insurance_renewal = insurance
	@mail_list = @@setmail.find_by_category("Insurance renewal")
	#InsuranceRenewal_Car_ManufactureYear
	@n_template = EmailNotificationTemplate.find_by_category("Insurance renewal mail-dealer")
	@insurance_request_dealer = @n_template.template % { InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:insurance.bike, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:insurance.expiry_date.strftime("%d").to_i.ordinalize, month:insurance.expiry_date.strftime("%B"), year:insurance.expiry_date.strftime("%Y"), weekday:insurance.expiry_date.strftime("%A"), vehicle_kms:insurance.kms }
	@subject = @n_template.title  % { InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:insurance.bike, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:insurance.expiry_date.strftime("%d").to_i.ordinalize, month:insurance.expiry_date.strftime("%B"), year:insurance.expiry_date.strftime("%Y"), weekday:insurance.expiry_date.strftime("%A"), vehicle_kms:insurance.kms }
	mail :to => @mail_list.email, :subject => @subject
end

def insurance_renewal_confirm(insurance)
	@vehicle_model = insurance.model
	@n_template = EmailNotificationTemplate.find_by_category("Insurance renewal mail-user")
	@insurance_request_user = @n_template.template % { InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:insurance.bike, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:insurance.expiry_date.strftime("%d").to_i.ordinalize, month:insurance.expiry_date.strftime("%B"), year:insurance.expiry_date.strftime("%Y"), weekday:insurance.expiry_date.strftime("%A"), vehicle_kms:insurance.kms }
	@subject = @n_template.title  % { InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:insurance.bike, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:insurance.expiry_date.strftime("%d").to_i.ordinalize, month:insurance.expiry_date.strftime("%B"), year:insurance.expiry_date.strftime("%Y"), weekday:insurance.expiry_date.strftime("%A"), vehicle_kms:insurance.kms }
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
	@feedback_confirm_dealer = @n_template.template % { Feedback_Customer_Name:feedback.name, Feedback_Customer_Number:feedback.mobile, Feedback_Customer_Email:feedback.email, Feedback_Title:feedback.feedback_type, Feedback_Description:feedback.comment  }
	@subject = @n_template.title % { Feedback_Customer_Name:feedback.name, Feedback_Customer_Number:feedback.mobile, Feedback_Customer_Email:feedback.email, Feedback_Title:feedback.feedback_type, Feedback_Description:feedback.comment }
	mail :to => @mail_list.email, :subject => @subject
end

end
