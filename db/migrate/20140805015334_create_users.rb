class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.text :bio
      t.string :public_location
      t.boolean :admin
      t.boolean :banned
      t.string :image  
      t.integer :sms_code
      t.datetime :last_seen_at
      t.datetime :last_visited_inbox_at

      t.timestamps
    end
  end
end
