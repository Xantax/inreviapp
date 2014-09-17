class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :promotion]
  before_action :authenticate_user!, except: [:show, :index, :promotion]
  before_action :require_permission, only: [:edit, :update]
  #before_action :must_be_completely_verified, except: [:show, :index]

  def index
    @poffers = PromotedOffer.published.order('created_at DESC').paginate(:page => params[:page]).limit(2)
    @offers = Offer.published.order('created_at DESC').paginate(:page => params[:page], :per_page => 1)
  end
  
  def search
    @offers = Offer.published.search(params[:search]).paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @offer.increment!(:total_clicks)
    if user_signed_in?
    @promoted_offer = PromotedOffer.new
    end
    @reviewable = @offer
    @reviews = @reviewable.reviews.where("buyer_id != ?", @offer.user.id).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    @positive_reviews = @reviewable.reviews.positive.where("buyer_id != ?", @offer.user.id)
    @negative_reviews = @reviewable.reviews.negative.where("buyer_id != ?", @offer.user.id)
    @convoable = @offer
    @conversations = @convoable.conversations
    @conversation = Conversation.new
  end

  def new
    @offer = Offer.new(:sell => (params[:sell] == '1'))
  end

  def edit
  end

  def create
    @offer = Offer.new(offer_params)

    respond_to do |format|
      if @offer.save
        
        @offer.create_activity :create, owner: current_user
        
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
  
  def promotion
  end

  private

    def set_offer
      @offer = Offer.find(params[:id])
    end

    def offer_params
      params.require(:offer).permit(:name, :description, :image, :new, :price, :user_id, :tag_list, :deleted, :image_a, :image_b, :image_c, :image_d, :image_e, :location, :quantity, :barcode, :free_delivery, :sell)
    end
  
    def require_permission
      if current_user != Offer.find(params[:id]).user
        redirect_to root_path
      end
    end
end
