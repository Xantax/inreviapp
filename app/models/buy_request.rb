class BuyRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation, :counter_cache => true
  belongs_to :offer
end
