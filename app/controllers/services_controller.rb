class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :promotion]
  before_action :authenticate_user!, except: [:show, :index, :promotion]
  before_action :require_permission, only: [:edit, :update]
  before_action :must_be_completely_verified, except: [:show, :index, :search]

  def index
    @services = Service.published.order('created_at DESC').paginate(:page => params[:page], :per_page => 20)
  end
  
  def search
    @pservices = PromotedService.published.search(params[:search]).paginate(:page => params[:page]).limit(2)
    @services = Service.published.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @service.increment!(:total_clicks)
    @promoted_service = PromotedService.new
    @reviewable = @service
    @reviews = @reviewable.reviews.where("buyer_id != ?", @service.user.id).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    @positive_reviews = @reviewable.reviews.positive.where("buyer_id != ?", @service.user.id)
    @negative_reviews = @reviewable.reviews.negative.where("buyer_id != ?", @service.user.id)
    @convoable = @service
    @conversations = @convoable.conversations
    @conversation = Conversation.new
  end

  def new
    @service = Service.new
  end

  def edit
  end

  def create
    @service = Service.new(service_params)
      if @service.save       
        @service.create_activity :create, owner: current_user
        redirect_to @service
      else
        render :new
      end
  end

  def update
      if @service.update(service_params)
        redirect_to @service
      else
        render :edit
      end
  end
  
  def promotion
  end

  private

    def set_service
      @service = Service.find(params[:id])
    end

    def service_params
      params.require(:service).permit(:name, :description, :image, :price, :user_id, :tag_list, :deleted, :location)
    end
  
    def require_permission
      if current_user != Service.find(params[:id]).user
        redirect_to root_path
      end
    end
end