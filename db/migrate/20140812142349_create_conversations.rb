class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :user, index: true
      t.references :offer, index: true
      t.integer :recipient_id
      t.integer :messages_count, default: 0
      t.datetime :content_changed_at

      t.timestamps
    end
  end
end
