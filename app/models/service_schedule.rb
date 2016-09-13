class ServiceSchedule < ActiveRecord::Base
	audited
	belongs_to :bike

	def bike_name
		Bike.find(self.bike_id).name
	end

	def as_json(options={})
		super.as_json(options).merge({:bike_name => bike_name })
	end

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			bike_colors = find_by_id(row["id"]) || new
			bike_colors.attributes = row.to_hash
			bike_colors.save!
		end
	end
	
end
