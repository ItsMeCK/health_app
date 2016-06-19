class CreateKeyFeatures < ActiveRecord::Migration
  def change
    create_table :key_features do |t|
      t.integer :bike_id
      t.jsonb :features

      t.timestamps null: false
    end
  end
end
