class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :only_admin, only: [:index]
  before_action :correct_user, only: [:edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @users = User.all
  end

  def show
    @positive_reviews = Review.positive.where(seller_id: params[:id])
    @negative_reviews = Review.negative.where(seller_id: params[:id])
    @user_offers = Offer.published.where(user_id: params[:id]).paginate(:page => params[:page], :per_page => 20)
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def user_params
      params.require(:user).permit(:name, :email, :credit, :bio, :language, :public_location, :admin, :banned, :image, :phone_code, :second_language)
    end
  
end
