class CreateBuyRequests < ActiveRecord::Migration
  def change
    create_table :buy_requests do |t|
      t.references :user, index: true
      t.references :conversation, index: true
      t.references :offer, index: true

      t.timestamps
    end
  end
end
