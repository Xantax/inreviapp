class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :destroy, :requestz, :confirm_order]
  before_action :require_permission_for_deleting, only: :destroy
  before_action :require_permission, only: :destroy
  before_action :correct_conversation, only: :show
  before_action :authenticate_user!
  before_action :must_be_completely_verified, except: [:index]
  before_filter :record_last_inbox_visit, only: [:index, :show]
  before_filter :load_convoable, except: [:index]
  before_filter :permission_to_request, only: [:requestz]
  before_filter :permission_to_confirm, only: [:confirm_order]
  
  def index
    @conversations = Conversation.ordered_conversations.paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @messages = Message.where(conversation_id: params[:id]).paginate(:page => params[:page], :per_page => 15)
    @review = Review.new
  end
  
  def create 
    @conversation = @convoable.conversations.new(conversation_params)
    
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
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
  
  def requestz
    @conversation.toggle!(:request)
    @conversation.touch(:content_changed_at)
    UserMailer.new_buy_request(@conversation).deliver
    redirect_to @conversation
  end
  
  def confirm_order
    @conversation.toggle!(:confirm)
    @conversation.touch(:content_changed_at)
    UserMailer.new_order(@conversation).deliver
    redirect_to @conversation
  end

  private
  
  def set_conversation
    @conversation = Conversation.find(params[:id])
  end
  
  def load_convoable
    resource, id = request.path.split('/')[1, 2]
    @convoable = resource.singularize.classify.constantize.find(id)
  end
  
  def conversation_params
    params.require(:conversation).permit(:user_id, :recipient_id, :buy_request, :request, :confirm)
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
  
  def permission_to_request
    unless current_user == Conversation.find(params[:id]).user
      redirect_to root_path
    end
  end
  
  def permission_to_confirm
    unless current_user.id == Conversation.find(params[:id]).recipient_id
      redirect_to root_path
    end
  end
  
  def require_permission_for_deleting
    if @conversation.messages_count > 0
      redirect_to root_path
    end
  end
  
  def correct_conversation
    unless (current_user.id == @conversation.user_id) || (current_user.id == @conversation.recipient_id) || (current_user.admin)
      redirect_to root_path
    end
  end
end


