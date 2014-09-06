class CreatePromotedOffers < ActiveRecord::Migration
  def change
    create_table :promoted_offers do |t|
      t.references :user, index: true
      t.integer :clicks, default: 0
      t.integer :set_clicks, default: 0
      t.belongs_to :promotable, polymorphic: true

      t.timestamps
    end
    add_index :promoted_offers, [:promotable_id, :promotable_type]
  end
end
