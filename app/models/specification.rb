class Specification < ActiveRecord::Base
	audited
	belongs_to :specification_type
	belongs_to :bike

	def specification_type
		 SpecificationType.find_by_id(self.specification_type_id).try(:name)
	end

	def bike_type
	    Bike.find_by_id(self.bike_id).try(:name)
	end

	def as_json(options={})
		super.as_json(options).merge({ :bike_name => bike_type, :specifications_type => specification_type })
	end

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			bikes = find_by_id(row["id"]) || new
			bikes.attributes = row.to_hash
			bikes.save!
		end
	end

end
