class UserMailer < ActionMailer::Base
  default from: "support@inrevi.com"
  
  def new_message(message)
    @message = message
    @author = message.sender
    @user = message.recipient
    @offer = message.conversation.offer
    @url  = 'http://www.inrevi.com/conversations'
    
    mail(to: @user.email, subject: 'Inrevi - You have a new message')
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
    
    mail(to: @user.email, subject: 'Inrevi - Your request was approved by the seller')
  end
end
