class CreateKeyFeatureTypes < ActiveRecord::Migration
  def change
    create_table :key_feature_types do |t|
      t.string :feature_type_name
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
