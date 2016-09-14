desc "Initialize GCM Configs"
task :gcm_init => :environment do
	app = Rpush::Gcm::App.new
	app.name = "Avinashi-ktm"
	app.auth_key = "AIzaSyB97d5jgkbaxf6ckDg5pTPdJvq2v5jvh4o"
	app.connections = 1
	app.save!
end