class Review < ActiveRecord::Base
  include PublicActivity::Common
  
  scope :positive, -> { where(positive: true) }
  scope :negative, -> { where(positive: false) }
  
  def self.only_buyers
    self.where("buyer_id != ?", self.offer.user.id)
  end
  
  belongs_to :conversation, :counter_cache => true
  belongs_to :reviewable, polymorphic: true
  belongs_to :buyer, :foreign_key => :buyer_id, :class_name => 'User'
  belongs_to :seller, :foreign_key => :seller_id, :class_name => 'User'
  
  mount_uploader :image, ImageUploader
  
  validates :body, presence: true
  
end
