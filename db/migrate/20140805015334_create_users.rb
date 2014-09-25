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
      t.integer :confirm_code
      t.decimal :credit, default: 10
      t.datetime :last_seen_at
      t.datetime :last_visited_inbox_at
      t.integer :num_following, default: 0
      t.integer :num_followers, default: 0

      t.timestamps
    end
  end
end
