class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :only_two_reviews, only: [:new, :create]
  before_action :one_per_user, only: [:new, :create]
  before_action :require_permission, only: [:edit, :update]
  before_action :must_be_completely_verified, only: [:new, :create, :edit, :update]

  def show
  end

  def new
    @conversation = Conversation.find(params[:conversation_id])
    @review = Review.new
  end

  def edit
    @conversation = Conversation.find(params[:conversation_id])
  end

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @review = @conversation.reviews.create(review_params)
      if @review.save
        @review.create_activity :create, owner: current_user 
        redirect_to @conversation
      else
        render :new
      end
  end

  def update   
    @conversation = @review.conversation
      if @review.update(review_params)
        redirect_to @review
      else
        render :edit
      end
  end

  private

    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:positive, :body, :proof, :image, :offer_id, :buyer_id, :seller_id, :order_id, :conversation_id, :reviewable_id, :reviewable_type)
    end
  
    # There should be only 2 reviews per conversation
    def only_two_reviews
      @conversation = Conversation.find(params[:conversation_id])
      if @conversation.reviews_count == 2
        redirect_to root_path
      end
    end
  
    # There should be only 2 reviews per conversation
    def one_per_user
      @conversation = Conversation.find(params[:conversation_id])
      if @conversation.reviews_count == 1
        @conversation.reviews.first(1).each do |review|
          if current_user.id == review.buyer_id
            redirect_to root_path
          end
        end
      end
    end
  
  # Only author of the review can edit it
    def require_permission
      if current_user.id != Review.find(params[:id]).buyer_id
        redirect_to root_path
      end
    end
  
end
