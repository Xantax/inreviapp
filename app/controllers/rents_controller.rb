class RentsController < ApplicationController
  before_action :set_rent, only: [:show, :edit, :update, :promotion, :imaging, :remove]
  before_action :authenticate_user!, except: [:show, :index, :promotion, :imaging, :remove]
  before_action :require_permission, only: [:edit, :update, :imaging, :remove]
  #before_action :must_be_completely_verified, except: [:show, :index, :search]

  def index
    @rents = Rent.published.order('created_at DESC').paginate(:page => params[:page], :per_page => 20)
  end
  
  def search
    @prents = PromotedRent.published.search(params[:search]).paginate(:page => params[:page]).limit(2)
    @rents = Rent.published.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @rent.increment!(:total_clicks)
    @reviewable = @rent
    @reviews = @reviewable.reviews.where("buyer_id != ?", @rent.user.id).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    @positive_reviews = @reviewable.reviews.positive.where("buyer_id != ?", @rent.user.id)
    @negative_reviews = @reviewable.reviews.negative.where("buyer_id != ?", @rent.user.id)
    @convoable = @rent
    @conversations = @convoable.conversations
    @conversation = Conversation.new
  end

  def new
    @rent = Rent.new(:sell => (params[:sell] == '1'))
  end

  def edit
  end

  def create
    @rent = Rent.new(rent_params)
      if @rent.save        
        @rent.create_activity :create, owner: current_user
        redirect_to @rent
      else
        render :new
      end
  end

  def update
      if @rent.update(rent_params)
        redirect_to @rent
      else
        render :edit
      end
  end
  
  def promotion
  end
  
  def imaging
  end
  
  def remove
    @rent.toggle!(:deleted)
    redirect_to root_url
  end

  private

    def set_rent
      @rent = Rent.find(params[:id])
    end

    def rent_params
      params.require(:rent).permit(:name, :description, :image, :location, :tag_list, :deleted, :image_a, :image_b, :image_c, :image_d, :image_e, :user_id, :total_clicks, :quantity, :sell, :price, :temporal_id, :per_temporal_id)
    end
  
    def require_permission
      if current_user != Rent.find(params[:id]).user
        redirect_to root_path
      end
    end
end
