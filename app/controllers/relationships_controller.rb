class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  #before_action :must_be_completely_verified

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    User.increment_counter(:num_following, current_user)
    User.increment_counter(:num_followers, @user.id)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    User.decrement_counter(:num_following, current_user)
    User.decrement_counter(:num_followers, @user.id)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end