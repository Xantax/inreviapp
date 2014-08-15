class OrdersController < ApplicationController
  before_action :set_order, only: [:show]
  before_action :none_other_order, only: [:create]
  before_action :set_conversation
  before_action :user_is_convo_recipient, only: [:create]
  before_action :there_is_buy_request, only: [:create]
  before_action :authenticate_user!

  def show
  end

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @order = @conversation.orders.create(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @conversation }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end
  
    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end

    def order_params
      params.require(:order).permit(:offer_id, :conversation_id, :buyer_id, :seller_id)
    end
  
    # Only 1 order per conversation
      def none_other_order
        @conversation = Conversation.find(params[:conversation_id])
        unless @conversation.orders_count < 1
            redirect_to root_path
        end
      end

    # User is the seller
      def user_is_convo_recipient
        @conversation = Conversation.find(params[:conversation_id])
        unless current_user.id == @conversation.recipient_id
          redirect_to root_path
        end
      end
  
    # Make sure there is a buy_request
      def there_is_buy_request
        @conversation = Conversation.find(params[:conversation_id])
        unless @conversation.buy_requests_count > 0
            redirect_to root_path
        end
      end
  
end
