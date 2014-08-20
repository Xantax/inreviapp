class CreatePromotedOffers < ActiveRecord::Migration
  def change
    create_table :promoted_offers do |t|
      t.references :user, index: true
      t.references :offer, index: true
      t.integer :clicks, default: 0
      t.integer :set_clicks, default: 0

      t.timestamps
    end
  end
end
