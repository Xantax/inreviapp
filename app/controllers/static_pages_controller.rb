class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:first_message, :adscenter, :users_products, :users_services, :users_rents, :users_jobs]
  
  def home
    if user_signed_in?
      @alert = Alert.new
      @pactivities = PublicActivity::Activity.paginate(:page => params[:page], :per_page => 15).order("created_at desc").where(owner_id: User.all_ids, owner_type: "User")
      @activities = PublicActivity::Activity.paginate(:page => params[:page], :per_page => 15).order("created_at desc").where(owner_id: current_user.followed_user_ids.insert(0, current_user.id), owner_type: "User")
    end
  end
  
  def terms
  end
  
  def howworks
  end
  
  def first_message
  end
  
  def adscenter
  end
  
  def users_products
    @user_products = Offer.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 10).order("created_at desc")
  end
  
  def users_services
    @user_services = Service.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 10).order("created_at desc")
  end 
  
  def users_rents
    @user_rents = Rent.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 10).order("created_at desc")
  end  
  
  def users_jobs
    @user_jobs = Work.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 10).order("created_at desc")
  end 
end
