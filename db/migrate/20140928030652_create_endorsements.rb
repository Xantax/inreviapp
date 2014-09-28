class CreateEndorsements < ActiveRecord::Migration
  def change
    create_table :endorsements do |t|
      t.text :body
      t.references :user, index: true
      t.integer :writer_id
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
