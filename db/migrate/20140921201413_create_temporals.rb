class CreateTemporals < ActiveRecord::Migration
  def change
    create_table :temporals do |t|
      t.string :name

      t.timestamps
    end
  end
end
