class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :location
      t.string :tag_list
      t.decimal :price
      t.boolean :deleted
      t.references :user, index: true
      t.integer :total_clicks
      t.integer :per_temporal_id

      t.timestamps
    end
  end
end
