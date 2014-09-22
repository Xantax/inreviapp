class PromotedRentsController < ApplicationController
  before_action :set_promoted_rent, only: [:show]
  #before_action :only_admin, except: [:show]
  #before_action :must_be_completely_verified, except: [:show]

  def show
    @promoted_rent.increment!(:clicks)
    redirect_to @promoted_rent.rent
  end

  def new
    @rent = Rent.find(params[:rent_id])
    @promoted_rent = PromotedRent.new
  end

  def create
    @rent = Rent.find(params[:rent_id])
    @promoted_rent = @rent.promoted_rents.create(promoted_rent_params)

    respond_to do |format|
      if @promoted_rent.save
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @promoted_rent }
      else
        format.html { render :new }
        format.json { render json: @promoted_rent.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_promoted_rent
      @promoted_rent = PromotedRent.find(params[:id])
    end

    def promoted_rent_params
      params.require(:promoted_rent).permit(:name, :location, :tag_list, :price, :image, :quantity, :user_id, :rent_id, :clicks, :set_clicks, :sell, :unavailable, :temporal_id, :per_temporal_id)
    end
end
