class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.text :body
      t.references :user, index: true
      t.string :image

      t.timestamps
    end
  end
end
