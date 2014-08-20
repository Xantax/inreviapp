class PromotedOffersController < ApplicationController
  before_action :set_promoted_offer, only: [:show]
  before_action :must_be_completely_verified

  def new
    @offer = Offer.find(params[:offer_id])
    @promoted_offer = PromotedOffer.new
  end
  
  def show
    @promoted_offer.increment!(:clicks)
    redirect_to @promoted_offer.offer
  end
  
  def create
    @offer = Offer.find(params[:offer_id])
    @promoted_offer = @offer.promoted_offers.create(promoted_offer_params)

    respond_to do |format|
      if @promoted_offer.save
        format.html { redirect_to root_path, notice: 'Your offer is now promoted' }
        format.json { render :show, status: :created, location: @promoted_offer }
      else
        format.html { render :new }
        format.json { render json: @promoted_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_promoted_offer
      @promoted_offer = PromotedOffer.find(params[:id])
    end

    def promoted_offer_params
      params.require(:promoted_offer).permit(:user_id, :offer_id, :set_clicks)
    end
end
