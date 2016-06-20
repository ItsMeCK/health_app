50.times do
	user = User.new
	user.email = FFaker::Internet.safe_email
	user.password = "Secret#123"
	user.save
end

Profile.all.each do |profile|
	profile.update(:full_name => FFaker::Name.name, :mobile => FFaker::PhoneNumberCU.e164_home_work_phone_number, :dob => FFaker::IdentificationESCO.expedition_date, :gender => ["Male", "Female"].shuffle.first, :bike_owned => Bike.pluck(:name).shuffle.first, :riding_since => FFaker::Vehicle.year, :address => FFaker::AddressUS.street_address, :location => FFaker::AddressUS.city, :profession => FFaker::Job.title, :bio => FFaker::DizzleIpsum.paragraph, :hog_privacy => [true, false].shuffle.first, :profile_image => FFaker::Avatar.image)
end


10.times do
bike_type = BikeType.create(name: FFaker::Vehicle.model, tagline: FFaker::HipsterIpsum.sentence, available: true)
end

50.times do
bike = Bike.create(name: FFaker::Vehicle.make, description: FFaker::HipsterIpsum.sentence, tagline: FFaker::HipsterIpsum.sentence, available: true, bike_type_id: BikeType.pluck(:id).shuffle.first )
end

ids = Bike.pluck(:id)
ids.each do |id|
	specification = Specification.create( bike_id: id, pricing: {"#{FFaker::Vehicle.mfg_color.titleize}": "Rs. 4,82,000"}, dimensions: { "Length": "2,225 mm", "Seat Height, Unladen": "710 mm", "Ground Clearance": "145 mm", "Rake (steering head) (deg)": "32", "Trail": "115 mm", "Wheelbase": "1,535 mm", "Tires, Front Specification": "\'11F\' Bias 100/80 R17", "Tires, Rear Specification": "\'11\' Radial 140/75 R15", "Fuel Capacity": "13.1 L", "Oil Capacity (w/filter)": "3.1 L", "Weight, As Shipped": "223 Kg", "Weight, In Running Order": "229 Kg" }, engine: { "Engine": "Liquid-cooled, Revolution X™ V-Twin", "Bore": "85 mm", "Stroke": "66 mm", "Displacement": "749 cc", "Compression Ratio": "0.459027777777778", "Fuel System":  "3 Mikuni Single Port Fuel Injection, 38 mm bore" }, chassis: { "Exhaust": "N/A", "Wheels, Front Type": "Black 7-Spoke Cast Aluminum with Machined Rim Highlights", "Wheels, Rear Type": "Black, 7-Spoke Cast Aluminum with Machined Rim Highlights", "Brakes, Caliper Type": "2-piston floated front and rear", "Wheels, Optional Style Type": " "}, performance: { "Engine Torque Testing Method": "EEC/95/1", "Engine Torque": "59Nm", "Engine Torque (rpm)": "4000RPM", "Lean Angle, Right (deg.)": "28.5", "Lean Angle, Left (deg.)": "28.5", "Fuel Economy: Combined City/Hwy": "5.74 L/100 km" }, electric: {"Lights (as per country regulation), Indicator Lamps": "High beam, neutral, low oil pressure, turn signals, engine diagnostics, low fuel warning", "Gauges": "N/A" }, drivetrain: { "Primary Drive": "Gear, 36/68 ratio", "Gear Ratios (overall) 1st": "14.272", "Gear Ratios (overall) 2nd": "10.074", "Gear Ratios (overall) 3rd": "7.446", "Gear Ratios (overall) 4th": "6.006", "Gear Ratios (overall) 5th": "5.037", "Gear Ratios (overall) 6th": "4.533" } )
end
