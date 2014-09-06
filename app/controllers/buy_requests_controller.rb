class BuyRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation
  before_action :there_are_messages
  before_action :none_other_request
  before_action :creator_of_convo

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @buy_request = @conversation.buy_requests.create(buy_request_params)

    respond_to do |format|
      if @buy_request.save
        
        UserMailer.new_buy_request(@buy_request).deliver
        
        format.html { redirect_to @conversation }
        format.json { render :show, status: :created, location: @buy_request }
      else
        format.html { render :new }
        format.json { render json: @buy_request.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end

    def buy_request_params
      params.require(:buy_request).permit(:user_id, :conversation_id, :buyable_id, :buyable_type)
    end
  
  # Only create a request if there is some activity
    def there_are_messages
      @conversation = Conversation.find(params[:conversation_id])
      unless @conversation.messages_count > 1
        redirect_to root_path
      end
    end
  
  # Only 1 request per conversation
    def none_other_request
      @conversation = Conversation.find(params[:conversation_id])
      unless @conversation.buy_requests_count < 1
        redirect_to root_path
      end
    end

  # User has created a conversation
    def creator_of_convo
      @conversation = Conversation.find(params[:conversation_id])
      unless @conversation.user_id == current_user.id
          redirect_to root_path
      end
    end
    
  
end
