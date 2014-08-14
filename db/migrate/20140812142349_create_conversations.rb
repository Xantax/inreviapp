class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :user, index: true
      t.references :offer, index: true
      t.integer :recipient_id
      t.integer :messages_count, default: 0
      t.datetime :content_changed_at
      t.integer :buy_requests, default: 0

      t.timestamps
    end
    add_index :conversations, :recipient_id
  end
end
