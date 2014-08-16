class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :require_permission, only: [:edit, :update]
  before_action :must_be_completely_verified, except: [:show, :index]

  def index
    if params[:tag]
      @offers = Offer.tagged_with(params[:tag])
    else
      @offers = Offer.all.order('created_at DESC')
    end
  end

  def show
    @promoted_offer = PromotedOffer.new
    @reviews = Review.where("buyer_id != ?", @offer.user.id)
    @positive_reviews = Review.positive.where("buyer_id != ?", @offer.user.id)
    @negative_reviews = Review.negative.where("buyer_id != ?", @offer.user.id)
  end

  def new
    @offer = Offer.new
  end

  def edit
  end

  def create
    @offer = Offer.new(offer_params)

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to @offer }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_offer
      @offer = Offer.find(params[:id])
    end

    def offer_params
      params.require(:offer).permit(:name, :description, :image, :service, :price, :user_id, :tag_list, :deleted)
    end
  
    def require_permission
      if current_user != Offer.find(params[:id]).user
        redirect_to root_path
      end
    end
end
