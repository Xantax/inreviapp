class CreatePromotedRents < ActiveRecord::Migration
  def change
    create_table :promoted_rents do |t|
      t.string :name
      t.string :location
      t.string :tag_list
      t.decimal :price
      t.string :image
      t.integer :quantity
      t.references :user, index: true
      t.references :rent, index: true
      t.integer :clicks
      t.integer :set_clicks
      t.boolean :sell
      t.boolean :unavailable
      t.integer :temporal_id
      t.integer :per_temporal_id

      t.timestamps
    end
  end
end
