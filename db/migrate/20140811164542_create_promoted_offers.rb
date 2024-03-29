class CreatePromotedOffers < ActiveRecord::Migration
  def change
    create_table :promoted_offers do |t|
      t.string :name
      t.string :location
      t.string :tag_list
      t.decimal :price
      t.string :image
      t.boolean :new
      t.boolean :sell
      t.integer :quantity
      t.integer :barcode
      t.boolean :free_delivery
      t.references :user, index: true
      t.integer :clicks, default: 0
      t.integer :set_clicks, default: 0
      t.references :offer, index: true

      t.timestamps
    end
  end
end
