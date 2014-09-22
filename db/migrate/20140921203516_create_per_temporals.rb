class CreatePerTemporals < ActiveRecord::Migration
  def change
    create_table :per_temporals do |t|
      t.string :name

      t.timestamps
    end
  end
end
