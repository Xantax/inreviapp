class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :location
      t.string :tag_list
      t.references :user, index: true
      t.boolean :deleted
      t.integer :temporal_id
      t.integer :per_temporal_id
      t.integer :total_clicks
      t.integer :quantity, default: 1
      t.decimal :price

      t.timestamps
    end
  end
end
