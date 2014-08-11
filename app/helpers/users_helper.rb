module UsersHelper
  
  def current_user?(user)
    user == current_user
  end
  
  # Number of total incoins specific user has
  def total_incoins
    current_user.credit - ((current_user.promoted_offers.count)*50)
  end
  
  # Prevent a user from creating promoted_offers if total_incoins is < 50
  def user_not_enough_credit
    if total_incoins < 50
      redirect_to buycredit_path
    end
  end
  
end
