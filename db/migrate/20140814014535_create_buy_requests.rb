class CreateBuyRequests < ActiveRecord::Migration
  def change
    create_table :buy_requests do |t|
      t.references :user, index: true
      t.belongs_to :conversation
      t.references :offer, index: true

      t.timestamps
    end
  end
end
