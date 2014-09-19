class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :promotion]
  before_action :authenticate_user!, except: [:show, :index, :promotion]
  before_action :require_permission, only: [:edit, :update]
  #before_action :must_be_completely_verified, except: [:show, :index]offer

  def index
      @jobs = Job.published.order('created_at DESC').paginate(:page => params[:page], :per_page => 20)
  end
  
  def search
    @jobs = Job.published.search(params[:search]).paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @job.increment!(:total_clicks)
    if user_signed_in?
    @promoted_offer = PromotedOffer.new
    end
    @reviewable = @job
    @reviews = @reviewable.reviews.where("buyer_id != ?", @job.user.id).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    @positive_reviews = @reviewable.reviews.positive.where("buyer_id != ?", @job.user.id)
    @negative_reviews = @reviewable.reviews.negative.where("buyer_id != ?", @job.user.id)
    @convoable = @job
    @conversations = @convoable.conversations
    @conversation = Conversation.new
    @promotable = @job
    @promoted_offer = @promotable.promoted_offers
    @promoted_offer = PromotedOffer.new
  end

  def new
    @job = Job.new
  end

  def edit
  end

  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        
        @job.create_activity :create, owner: current_user
        
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def promotion
  end

  private

    def set_job
      @service = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:name, :description, :image, :location, :deleted, :user_id, :total_clicks, :tag_list)
    end
  
    def require_permission
      if current_user != Job.find(params[:id]).user
        redirect_to root_path
      end
    end
end