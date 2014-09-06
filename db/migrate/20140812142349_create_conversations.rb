class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :user, index: true
      t.integer :recipient_id
      t.integer :messages_count, default: 0
      t.datetime :content_changed_at
      t.integer :buy_requests_count, default: 0
      t.integer :orders_count, default: 0
      t.integer :reviews_count, default: 0
      t.belongs_to :convoable, polymorphic: true

      t.timestamps
    end
    add_index :conversations, :recipient_id
    add_index :conversations, [:convoable_id, :convoable_type]
  end
end
