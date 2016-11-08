class AddProfession < ActiveRecord::Migration
  def change
  	add_column :ayurveda_dincharyas, :profession, :string
  	add_column :modern_dincharyas, :profession, :string
  end
end
