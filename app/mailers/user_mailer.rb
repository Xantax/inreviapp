class UserMailer < ActionMailer::Base
  default from: "support@inrevi.com"
  
  def new_message(message)
    @message = message
    @author = message.sender
    @user = message.recipient
    @offer = message.conversation.convoable
    @url  = 'http://www.inrevi.com/conversations'
    
    mail(to: @user.email, subject: 'Inrevi - You have a new message')
  end
  
  def new_buy_request(buy_request)
    @buy_request = buy_request
    @author = buy_request.user
    @user = buy_request.buyable.user
    @offer = buy_request.buyable
    @url  = 'http://www.inrevi.com/conversations'
    
    mail(to: @user.email, subject: 'Inrevi - You have a new request')
  end
  
  def new_order(order)
    @order = order
    @seller = order.orderable.user
    @user = order.buyer
    @offer = order.orderable
    @url  = 'http://www.inrevi.com/conversations'
    
    mail(to: @user.email, subject: 'Inrevi - Your request was approved by the seller')
  end
end
