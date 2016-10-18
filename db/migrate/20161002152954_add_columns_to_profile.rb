class AddColumnsToProfile < ActiveRecord::Migration
  def change
 	add_column :profiles, :age, :integer 
 	#add_column :profiles, :profession, :string	
  end
end
