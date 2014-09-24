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
      t.string :image_e
      t.string :location
      t.string :tag_list
      t.boolean :new
      t.boolean :sell
      t.decimal :price
      t.boolean :deleted, default: false
      t.references :user, index: true
      t.integer :total_clicks, default: 0
      t.integer :quantity, default: 1
      t.integer :barcode
      t.boolean :free_delivery, default: false

      t.timestamps
    end
  end
end
