class MessagesController < ApplicationController
  before_action :authenticate_user!
  #before_action :must_be_completely_verified

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.create(message_params)

    respond_to do |format|
      if @message.save
        
        UserMailer.new_message(@message).deliver
        
        format.html { redirect_to @conversation }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def message_params
      params.require(:message).permit(:recipient_id, :conversation_id, :body, :sender_id)
    end
end
