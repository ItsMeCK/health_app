class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.string :image
      t.integer :imageable_id
      t.string :imageable_type

      t.timestamps null: false
    end
  end
end
