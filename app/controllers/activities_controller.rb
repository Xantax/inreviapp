class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @pactivities = PublicActivity::Activity.paginate(:page => params[:page], :per_page => 15).order("created_at desc").where(owner_id: User.all_ids, owner_type: "User")
    @activities = PublicActivity::Activity.paginate(:page => params[:page], :per_page => 15).order("created_at desc").where(owner_id: current_user.followed_user_ids.insert(0, current_user.id), owner_type: "User")
  end
end
