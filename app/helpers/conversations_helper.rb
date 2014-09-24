module ConversationsHelper
  
  # 'Request to buy' button is shown to the creator of the conversation
  def user_can_send_buy_request
    (@conversation.messages_count > 1) && (@conversation.request == false) && (@conversation.user_id == current_user.id)
  end
  
  # Button to create order is shown to the seller
  def user_can_accept_offer
    (@conversation.request == true) && (current_user.id == @conversation.recipient_id) && (@conversation.confirm == false)
  end
  
end
