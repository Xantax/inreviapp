class RentsController < ApplicationController
  before_action :set_rent, only: [:show, :edit, :update, :promotion]
  before_action :authenticate_user!, except: [:show, :index, :promotion]
  before_action :require_permission, only: [:edit, :update]
  #before_action :must_be_completely_verified, except: [:show, :index]

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

    respond_to do |format|
      if @rent.save
        
        @rent.create_activity :create, owner: current_user
        
        format.html { redirect_to @rent, notice: 'Rent was successfully created.' }
        format.json { render :show, status: :created, location: @rent }
      else
        format.html { render :new }
        format.json { render json: @rent.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rent.update(rent_params)
        format.html { redirect_to @rent, notice: 'Rent was successfully updated.' }
        format.json { render :show, status: :ok, location: @rent }
      else
        format.html { render :edit }
        format.json { render json: @rent.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_rent
      @rent = Rent.find(params[:id])
    end

    def rent_params
      params.require(:rent).permit(:name, :description, :image, :location, :tag_list, :deleted, :user_id, :unavailable, :total_clicks, :quantity, :sell, :price, :temporal_id, :per_temporal_id)
    end
  
    def require_permission
      if current_user != Rent.find(params[:id]).user
        redirect_to root_path
      end
    end
end
