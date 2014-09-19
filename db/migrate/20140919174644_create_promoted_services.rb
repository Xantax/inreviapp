class CreatePromotedServices < ActiveRecord::Migration
  def change
    create_table :promoted_services do |t|
      t.string :name
      t.string :image
      t.string :location
      t.string :tag_list
      t.decimal :price
      t.references :user, index: true
      t.references :service, index: true
      t.integer :clicks, default: 0
      t.integer :set_clicks, default: 0

      t.timestamps
    end
  end
end
