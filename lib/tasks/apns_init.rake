# desc "Initialize APNS Configs"
# task :apns_init => :environment do
# 	app = Rpush::Apns::App.new
# 	app.name = "coromandal_harley_davidson"
# 	app.certificate = File.read("/path/to/sandbox.pem")
# 	app.environment = "sandbox" # APNs environment.
# 	app.password = "certificate password"
# 	app.connections = 1
# 	app.save!
# end