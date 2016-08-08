class UserMailer < ApplicationMailer
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

		mail :to => @mail_list.email, :subject => @subject, :body => @testride_confirm_dealer
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

		mail :to => testride.email, :subject => @subject, :body => @testdrive_confirm_user
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

end
