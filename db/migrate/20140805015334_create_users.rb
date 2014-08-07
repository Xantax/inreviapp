class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :credit, :default => 10
      t.text :bio
      t.string :website
      t.string :language
      t.string :public_location
      t.boolean :admin
      t.boolean :banned
      t.string :image  
      t.integer :sms_code
      t.datetime :last_seen_at

      t.timestamps
    end
  end
end
