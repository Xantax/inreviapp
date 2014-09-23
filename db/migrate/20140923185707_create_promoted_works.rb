class CreatePromotedWorks < ActiveRecord::Migration
  def change
    create_table :promoted_works do |t|
      t.string :name
      t.string :location
      t.string :tag_list
      t.decimal :price
      t.string :image
      t.integer :quantity
      t.references :user, index: true
      t.references :work, index: true
      t.integer :clicks, default: 0
      t.integer :set_clicks, default: 0
      t.integer :temporal_id
      t.integer :per_temporal_id

      t.timestamps
    end
  end
end
