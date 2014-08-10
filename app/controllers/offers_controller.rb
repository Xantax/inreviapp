class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  before_action :only_admin, only: [:index]
  before_action :require_permission, only: [:edit, :update, :destroy]
  #before_action :must_be_completely_verified, except: [:show]

  def index
    @offers = Offer.all.order('created_at DESC')
  end

  def show
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
        format.html { redirect_to @offer, notice: 'Thank you. We are now reviewing your offer' }
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
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_offer
      @offer = Offer.find(params[:id])
    end

    def offer_params
      params.require(:offer).permit(:name, :description, :image, :type, :price, :user_id)
    end
  
    def require_permission
      if current_user != Offer.find(params[:id]).user
        redirect_to root_path
      end
    end
end
