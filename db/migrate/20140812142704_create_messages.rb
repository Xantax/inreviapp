class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :conversation, index: true
      t.text :body
      t.integer :sender_id, index: true
      t.integer :recipient_id, index: true
      t.datetime :read_at

      t.timestamps
    end
  end
end
