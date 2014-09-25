class CreateRents < ActiveRecord::Migration
  def change
    create_table :rents do |t|
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
      t.boolean :deleted
      t.references :user, index: true
      t.integer :temporal_id
      t.integer :per_temporal_id
      t.integer :total_clicks
      t.integer :quantity, default: 1
      t.boolean :sell
      t.decimal :price

      t.timestamps
    end
  end
end
