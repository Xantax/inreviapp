module UsersHelper
  
  def current_user?(user)
    user == current_user
  end
  
  def total_incoins
    (current_user.credit.to_i) - (PromotedOffer.sum_of_all.to_i)
  end
  
end
