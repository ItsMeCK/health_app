class CreateAyurvedaDincharyas < ActiveRecord::Migration
  def change
    create_table :ayurveda_dincharyas do |t|
      t.string :title
      t.time :reminder_time
      t.text :description
      t.timestamps null: false
    end
  end
end
