class UserIdentification < ActiveRecord::Base
  mount_uploader :id_photo, ImageUploader
  mount_uploader :recent_photo, ImageUploader
  
  belongs_to :user
end
