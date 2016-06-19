class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.string :name
      t.text :description
      t.text :tagline
      t.boolean :available

      t.timestamps null: false
    end
  end
end
