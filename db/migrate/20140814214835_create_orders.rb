class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :offer, index: true
      t.references :conversation, index: true
      t.integer :buyer_id
      t.integer :seller_id
      t.integer :reviews_count, default: 0

      t.timestamps
    end
    add_index :orders, :buyer_id
    add_index :orders, :seller_id
  end
end
