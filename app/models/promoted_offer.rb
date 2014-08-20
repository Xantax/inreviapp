class PromotedOffer < ActiveRecord::Base
  belongs_to :user
  belongs_to :offer
  
  scope :published, -> { where('clicks <= set_clicks') }
  
  validates :set_clicks, numericality: { only_integer: true, :greater_than => 0, :less_than_or_equal_to => (user.credit) }
    
end