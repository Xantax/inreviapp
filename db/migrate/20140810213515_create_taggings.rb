class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :offer, index: true
      t.belongs_to :service, index: true
      t.belongs_to :job, index: true

      t.timestamps
    end
  end
end
