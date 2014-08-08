class CreateUserIdentifications < ActiveRecord::Migration
  def change
    create_table :user_identifications do |t|
      t.string :real_name
      t.string :city
      t.integer :zip_code
      t.string :address
      t.string :country
      t.string :id_photo
      t.string :recent_photo
      t.references :user, index: true

      t.timestamps
    end
  end
end
