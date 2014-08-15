class Review < ActiveRecord::Base
  belongs_to :offer
  belongs_to :order, :counter_cache => true
  belongs_to :buyer, :foreign_key => :buyer_id, :class_name => 'User'
  belongs_to :seller, :foreign_key => :seller_id, :class_name => 'User'
  
  mount_uploader :image, ImageUploader
end
