module AuthorizationsHelper
  
  # User has only one phone code
    def user_count_phone_code
      if current_user.phone_codes.count == 1
        redirect_to root_path
      end
    end
  
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
  
  # User has only one ID verification
    def user_count_identifications
      if current_user.user_identifications.count == 1
        redirect_to root_path
      end
    end
  
  # User has submitted a phone code
    def before_user_count_phone_code
      unless current_user.phone_codes.count == 1
        redirect_to root_path
      end
    end
  
  # User phone code is correct
    def before_phone_correct
      current_user.phone_codes.first(1).each do |code|
        unless code.code.to_i == current_user.sms_code
          redirect_to root_path
        end
      end
    end
  
end