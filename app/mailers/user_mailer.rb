class UserMailer < ActionMailer::Base
  default from: "support@inrevi.com"
  
  def new_conversation(conversation)
    @conversation = conversation
    @author = conversation.user
    @user = conversation.offer.user
    @offer = conversation.offer
    @url  = 'http://www.inrevi.com/conversations'
    
    mail(to: @user.email, subject: 'Inrevi - Someone wants to buy your offer')
  end
  
  def new_buy_request(buy_request)
    @buy_request = buy_request
    @author = buy_request.user
    @user = buy_request.offer.user
    @offer = buy_request.offer
    @url  = 'http://www.inrevi.com/conversations'
    
    mail(to: @user.email, subject: 'Inrevi - You have a new order')
  end
  
  def new_order(order)
    @order = order
    @seller = order.offer.user
    @user = order.buyer
    @offer = order.offer
    @url  = 'http://www.inrevi.com/conversations'
    
    mail(to: @user.email, subject: 'Inrevi - Your request to buy an offer was approved by the seller')
  end
end
