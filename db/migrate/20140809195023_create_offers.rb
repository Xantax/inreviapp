class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :type
      t.integer :price
      t.references :user, index: true

      t.timestamps
    end
  end
end
