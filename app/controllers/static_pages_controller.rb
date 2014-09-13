class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:first_message]
  
  def home
    if user_signed_in?
      @alert = Alert.new
      @promoted_offers = PromotedOffer.published.order('set_clicks DESC').paginate(:page => params[:page], :per_page => 20)
      @activities = PublicActivity::Activity.paginate(:page => params[:page], :per_page => 15).order("created_at desc").where(owner_id: current_user.followed_user_ids.insert(0, 1), owner_type: "User")
    end
  end
  
  def terms
  end
  
  def howworks
  end
  
  def first_message
  end
end
