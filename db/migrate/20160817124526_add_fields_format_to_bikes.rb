class AddFieldsFormatToBikes < ActiveRecord::Migration
  def change
  	add_column :bikes, :start_price, :integer
  	add_column :bikes, :end_price, :integer
  	add_column :bikes, :engine, :string
  	add_column :bikes, :bike_cc, :string
  end
end
