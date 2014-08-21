module UsersHelper
  
  def current_user?(user)
    user == current_user
  end
  
  def total_incoins
    current_user.max_num
  end
  
end
