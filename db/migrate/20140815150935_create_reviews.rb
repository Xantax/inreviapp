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
      t.references :conversation, index: true
      t.belongs_to :reviewable, polymorphic: true

      t.timestamps
    end
    add_index :reviews, :buyer_id
    add_index :reviews, :seller_id
    add_index :reviews, [:reviewable_id, :reviewable_type]
  end
end
