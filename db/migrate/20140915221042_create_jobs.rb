class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :location
      t.string :tag_list
      t.boolean :deleted
      t.boolean :remote
      t.references :user, index: true
      t.integer :total_clicks

      t.timestamps
    end
  end
end
