class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.paginate(:page => params[:page], :per_page => 15).order("created_at desc").where(owner_id: current_user.followed_user_ids.insert(0, current_user.id), owner_type: "User")
  end
end
