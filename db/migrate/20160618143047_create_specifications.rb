class CreateSpecifications < ActiveRecord::Migration
  def change
    create_table :specifications do |t|
      t.integer :bike_id
      t.jsonb :pricing, null: false, default: '{}'
      t.jsonb :dimensions, null: false, default: '{}'
      t.jsonb :engine, null: false, default: '{}'
      t.jsonb :drivetrain, null: false, default: '{}'
      t.jsonb :chassis, null: false, default: '{}'
      t.jsonb :performance, null: false, default: '{}'
      t.jsonb :electric, null: false, default: '{}'

      t.timestamps null: false
    end

    add_index :specifications, :pricing, using: :gin
    add_index :specifications, :dimensions, using: :gin
    add_index :specifications, :engine, using: :gin
    add_index :specifications, :drivetrain, using: :gin
    add_index :specifications, :chassis, using: :gin
    add_index :specifications, :performance, using: :gin
    add_index :specifications, :electric, using: :gin

  end
end
