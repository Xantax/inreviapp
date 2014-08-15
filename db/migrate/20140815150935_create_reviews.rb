class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.boolean :positive
      t.text :body
      t.text :proof
      t.string :image
      t.references :offer, index: true
      t.integer :buyer_id
      t.integer :seller_id
      t.references :order, index: true

      t.timestamps
    end
    add_index :reviews, :buyer_id
    add_index :reviews, :seller_id
  end
end
