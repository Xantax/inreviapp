module ConversationsHelper
  
  # 'Request to buy' button is shown to the creator of the conversation
  def user_can_send_buy_request
    (@conversation.messages_count > 2) && (@conversation.buy_request.blank?) && (@conversation.user_id == current_user.id)
  end
  
  # Button to create order is shown to the seller
  def user_can_accept_offer
    (@conversation.buy_request.present?) && (current_user.id == @conversation.recipient_id) && (@conversation.order.blank?)
  end
  
end
