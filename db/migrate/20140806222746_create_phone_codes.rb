class CreatePhoneCodes < ActiveRecord::Migration
  def change
    create_table :phone_codes do |t|
      t.string :code
      t.references :user, index: true

      t.timestamps
    end
  end
end
