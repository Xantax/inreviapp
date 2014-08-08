class UserIdentification < ActiveRecord::Base
  mount_uploader :id_photo, ImageUploader
  mount_uploader :recent_photo, ImageUploader
  
  belongs_to :user
  
  validates :id_photo, presence: true
  validates :recent_photo, presence: true
  validates :user_id, presence: true
end
