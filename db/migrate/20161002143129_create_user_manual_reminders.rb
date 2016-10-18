class CreateUserManualReminders < ActiveRecord::Migration
  def change
    create_table :user_manual_reminders do |t|
      t.time :rem_time
      t.string :title
      t.text :description
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
