class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]
  before_action :require_permission_for_deleting, only: :destroy
  before_action :require_permission, only: :destroy
  before_action :correct_conversation, only: :show
  before_action :authenticate_user!
  before_action :must_be_completely_verified
  before_filter :record_last_inbox_visit, only: [:index, :show]
  
  def index
    @conversations = Conversation.ordered_conversations
  end
  
  def show
    @messages = Message.where(conversation_id: params[:id])
    @review = Review.new
  end
  
  def create
    @offer = Offer.find(params[:offer_id])
    @conversation = @offer.conversations.create(conversation_params)
    
    respond_to do |format|
      if @conversation.save
        format.html { redirect_to @conversation }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { render :new }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url }
      format.json { head :no_content }
    end
  end

  private
  
  def set_conversation
    @conversation = Conversation.find(params[:id])
  end
  
  def conversation_params
    params.require(:conversation).permit(:user_id, :offer_id, :recipient_id, :buy_request)
  end
  
  def record_last_inbox_visit
    if current_user
      current_user.touch :last_visited_inbox_at
    end
  end
  
  def require_permission
    if current_user != Conversation.find(params[:id]).user
      redirect_to root_path
    end
  end
  
  def require_permission_for_deleting
    if @conversation.messages_count > 0
      redirect_to root_path
    end
  end
  
  def correct_conversation
    unless (current_user.id == @conversation.user_id) || (current_user.id == @conversation.recipient_id)
      redirect_to root_path
    end
  end
end


