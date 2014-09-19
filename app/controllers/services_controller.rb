class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :promotion]
  before_action :authenticate_user!, except: [:show, :index, :promotion]
  before_action :require_permission, only: [:edit, :update]
  #before_action :must_be_completely_verified, except: [:show, :index]offer

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

    respond_to do |format|
      if @service.save
        
        @service.create_activity :create, owner: current_user
        
        format.html { redirect_to @service }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
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