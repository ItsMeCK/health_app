desc "Initialize GCM Configs"
task :gcm_init => :environment do
	app = Rpush::Gcm::App.new
	app.name = "coromandal_harley_davidson"
	app.auth_key = "AIzaSyCwiu5Y_lUB1QAw-5ggZDI2SK1IMqr7z_4"
	app.connections = 1
	app.save!
end