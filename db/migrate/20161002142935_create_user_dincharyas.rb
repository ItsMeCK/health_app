class CreateUserDincharyas < ActiveRecord::Migration
  def change
    create_table :user_dincharyas do |t|
      t.string :title
      t.time :reminder_time
      t.text :description
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
