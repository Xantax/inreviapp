module AuthorizationsHelper
  
  # User is administrator
    def only_admin
      unless current_user.admin
        redirect_to root_path
      end
    end
  
  # User confirmed email
    def before_email
      if current_user.confirmed_at.blank?
        redirect_to root_path
      end
    end
  
  # User has only one phone number
    def user_count_phone_verifications
      if current_user.phone_verifications.count == 1
        redirect_to root_path
      end
    end
  
  # User has a phone number
    def user_has_number
      unless current_user.phone_verifications.count > 0
        redirect_to root_path
      end
    end
  
  # Must be completely verified
    def must_be_completely_verified
      unless current_user.sms_code.to_i == current_user.confirm_code.to_i
        redirect_to root_path
      end
    end
  
  # User is verified for views  
  def user_is_verified?
    current_user.sms_code.to_i == current_user.confirm_code.to_i
  end
  
  def user_in_not_verified
    current_user.sms_code.to_i != current_user.confirm_code.to_i
  end
  
end