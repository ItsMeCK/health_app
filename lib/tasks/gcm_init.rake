desc "Initialize GCM Configs"
task :gcm_init => :environment do
	app = Rpush::Gcm::App.new
	app.name = "coromandal_harley_davidson"
	app.auth_key = "AIzaSyALcTsYve4lkwzX-6Q28-cseedcfMwJNho"
	app.connections = 1
	app.save!
end