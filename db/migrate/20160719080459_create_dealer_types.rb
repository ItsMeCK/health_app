class CreateDealerTypes < ActiveRecord::Migration
  def change
    create_table :dealer_types do |t|
      t.string :dealer_type

      t.timestamps null: false
    end
  end
end
