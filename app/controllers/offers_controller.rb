class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :promotion, :imaging, :remove]
  before_action :authenticate_user!, except: [:show, :index, :promotion, :imaging, :remove]
  before_action :require_permission, only: [:edit, :update, :imaging, :remove]
  #before_action :must_be_completely_verified, except: [:show, :index, :search]

  def index
    @offers = Offer.published.order('created_at DESC').paginate(:page => params[:page], :per_page => 20)
  end
  
  def search
    @poffers = PromotedOffer.published.search(params[:search]).paginate(:page => params[:page]).limit(2)
    @offers = Offer.published.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @offer.increment!(:total_clicks)
    @promoted_offer = PromotedOffer.new
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

      if @offer.save        
        @offer.create_activity :create, owner: current_user
        redirect_to @offer
      else
        render :new
      end

  end

  def update
      if @offer.update(offer_params)
        redirect_to @offer
      else
        render :edit
      end
  end
  
  def promotion
  end
  
  def imaging
  end
  
  def remove
    @offer.toggle!(:deleted)
    redirect_to root_url
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
