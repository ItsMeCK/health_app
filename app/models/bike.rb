class Bike < ActiveRecord::Base
	belongs_to :bike_type
	has_many :specifications

	def my_bike_name
		@specifications = []
		self.specifications.each do |specification|
			@specification_name = SpecificationType.find_by_id(specification.specification_type_id).name
			@specifications << { "#{@specification_name}": specification }
		end
	  @specifications.flat_map(&:entries).group_by(&:first).map{|k,v| Hash[k, v.map(&:last)]}
	end

	def as_json(options={})
		super.as_json(options).merge({:specifications => my_bike_name})
	end

end