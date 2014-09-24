class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :promotion]
  before_action :authenticate_user!, except: [:show, :index, :promotion]
  before_action :require_permission, only: [:edit, :update]
  before_action :must_be_completely_verified, except: [:show, :index]

  def index
    @works = Work.published.order('created_at DESC').paginate(:page => params[:page], :per_page => 20)
  end
  
  def search
    @pworks = PromotedWork.published.search(params[:search]).paginate(:page => params[:page]).limit(2)
    @works = Work.published.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @work.increment!(:total_clicks)
    @reviewable = @work
    @reviews = @reviewable.reviews.where("buyer_id != ?", @work.user.id).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    @positive_reviews = @reviewable.reviews.positive.where("buyer_id != ?", @work.user.id)
    @negative_reviews = @reviewable.reviews.negative.where("buyer_id != ?", @work.user.id)
    @convoable = @work
    @conversations = @convoable.conversations
    @conversation = Conversation.new
  end

  def new
    @work = Work.new
  end

  def edit
  end

  def create
    @work = Work.new(work_params)

    respond_to do |format|
      if @work.save
        
        @work.create_activity :create, owner: current_user
        
        format.html { redirect_to @work, notice: 'Work was successfully created.' }
        format.json { render :show, status: :created, location: @work }
      else
        format.html { render :new }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @work.update(work_params)
        format.html { redirect_to @work, notice: 'Work was successfully updated.' }
        format.json { render :show, status: :ok, location: @work }
      else
        format.html { render :edit }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def promotion
  end

  private
  
    def set_work
      @work = Work.find(params[:id])
    end

    def work_params
      params.require(:work).permit(:name, :description, :image, :location, :tag_list, :user_id, :deleted, :temporal_id, :per_temporal_id, :total_clicks, :quantity, :price)
    end
  
    def require_permission
      if current_user != Work.find(params[:id]).user
        redirect_to root_path
      end
    end
end
