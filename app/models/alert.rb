class Alert < ActiveRecord::Base
  include PublicActivity::Common
  
  belongs_to :user
  mount_uploader :image, ImageUploader
end
