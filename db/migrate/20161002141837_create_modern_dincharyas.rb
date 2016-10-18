class CreateModernDincharyas < ActiveRecord::Migration
  def change
    create_table :modern_dincharyas do |t|
      t.string :title
      t.time :reminder_time
      t.text :description

      t.timestamps null: false
    end
  end
end
