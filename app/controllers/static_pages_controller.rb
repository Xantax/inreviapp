class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:first_message]
  
  def home
    if user_signed_in?
      @alert = Alert.new
      @activities = PublicActivity::Activity.paginate(:page => params[:page], :per_page => 15).order("created_at desc").where(owner_id: current_user.followed_user_ids.insert(0, current_user.id), owner_type: "User")
    end
  end
  
  def terms
  end
  
  def howworks
  end
  
  def first_message
  end
end
