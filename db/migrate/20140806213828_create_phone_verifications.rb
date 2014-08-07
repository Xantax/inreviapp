class CreatePhoneVerifications < ActiveRecord::Migration
  def change
    create_table :phone_verifications do |t|
      t.string :number
      t.references :user, index: true

      t.timestamps
    end
  end
end
