class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]

  before_filter :record_last_inbox_visit, only: [:index]
  
  def index
    @conversations = Conversation.ordered_conversations
  end

  def show
    @messages = Message.where(conversation_id: params[:id])
  end

  def new
    @conversation = Conversation.new
  end

  def edit
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

  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    def conversation_params
      params.require(:conversation).permit(:user_id, :offer_id, :recipient_id, :messages_count)
    end
  
    def record_last_inbox_visit
      if current_user
        current_user.touch :last_visited_inbox_at
      end
    end 
end
