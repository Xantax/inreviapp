class Order < ActiveRecord::Base
  belongs_to :offer, :counter_cache => true
  belongs_to :conversation
  belongs_to :buyer, :foreign_key => :buyer_id, :class_name => 'User'
  belongs_to :seller, :foreign_key => :seller_id, :class_name => 'User'
  
  has_many :reviews
end
