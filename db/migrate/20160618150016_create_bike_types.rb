class CreateBikeTypes < ActiveRecord::Migration
  def change
    create_table :bike_types do |t|
      t.string :name
      t.text :tagline
      t.boolean :available, default: false

      t.timestamps null: false
    end
  end
end
