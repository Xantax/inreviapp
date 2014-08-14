class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :name
      t.text :description
      t.string :image
      t.boolean :service
      t.integer :price
      t.boolean :deleted, default: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
