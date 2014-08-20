class PromotedOffer < ActiveRecord::Base
  belongs_to :user
  belongs_to :offer
  
  scope :published, -> { where('clicks <= set_clicks') }
  
  # Find PromotedOffers created by current_user
  scope :promos_by_cu, ->(user_id) { where(:user_id => User.current.id)}
  
  # Array of :set_clicks values
  def self.get_clickz
    self.promos_by_cu(User.current.id).map{ |v| v.set_clicks }
  end
  
  # Sum of all set_clicks values for the current_user
  def self.sum_of_all
    self.get_clickz.inject{|sum,x| sum + x }
  end
  
  # Total Incoins
  def self.tot_sum
    ((User.current.credit.to_i) - (self.sum_of_all.to_i))
  end
  
  validates :set_clicks, numericality: { only_integer: true, :greater_than => 0, :less_than_or_equal_to => (self.tot_sum) }
    
end
