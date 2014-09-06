class CreateBuyRequests < ActiveRecord::Migration
  def change
    create_table :buy_requests do |t|
      t.references :user, index: true
      t.references :conversation, index: true
      t.belongs_to :buyable, polymorphic: true

      t.timestamps
    end
    add_index :buy_requests, [:buyable_id, :buyable_type]
  end
end
