class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :image_a
      t.string :image_b
      t.string :image_c
      t.string :image_d
      t.string :location
      t.boolean :new
      t.integer :price
      t.boolean :deleted, default: false
      t.references :user, index: true
      t.integer :orders_count, default: 0
      t.integer :total_clicks, default: 0
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
