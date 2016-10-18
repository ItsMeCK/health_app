class CreateAyurvedaDincharyas < ActiveRecord::Migration
  def change
    create_table :ayurveda_dincharyas do |t|
      t.time :sleep_time
      t.time :wake_up_time
      t.time :break_fast_time
      t.time :lunch
      t.time :snacks_time
      t.time :sports
      t.time :hobbies
      t.time :dinner

      t.timestamps null: false
    end
  end
end
