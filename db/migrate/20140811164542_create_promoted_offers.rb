class CreatePromotedOffers < ActiveRecord::Migration
  def change
    create_table :promoted_offers do |t|
      t.references :user, index: true
      t.references :offer, index: true

      t.timestamps
    end
  end
end
