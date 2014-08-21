class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :record_user_activity
  before_filter :banned?
  before_filter :set_current_user
  
  include UsersHelper
  include AuthorizationsHelper
  include ConversationsHelper

  def banned?
    if current_user.present? && current_user.banned?
      sign_out current_user
      flash[:notice] = "Blocked!"
      root_path
    end
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :sms_code
  end
      
  private
    
  def record_user_activity
    if current_user
      current_user.touch :last_seen_at
    end
  end  
      
  def set_current_user
    User.currentz = current_user
  end    
      
end
