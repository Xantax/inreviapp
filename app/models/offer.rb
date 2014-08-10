class Offer < ActiveRecord::Base
  belongs_to :user
  
  mount_uploader :image, ImageUploader
  
  validates :name, length: { minimum: 50 }
  validates :description, length: { minimum: 1000 }
  validates :image, presence: true
  validates :user_id, presence: true
end
